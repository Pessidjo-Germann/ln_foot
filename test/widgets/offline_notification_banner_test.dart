import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ln_foot/blocs/network_bloc/network_bloc.dart';
import 'package:ln_foot/widgets/offline_notification_banner.dart';
import 'package:mockito/mockito.dart';

// Mock NetworkBloc for testing purposes
class MockNetworkBloc extends MockBloc<NetworkEvent, NetworkState> implements NetworkBloc {}

// A mock that can be used if we need to mock the constructor arguments of NetworkBloc,
// but for state emission testing, MockBloc is usually enough.
class MockConnectivityForBanner extends Mock implements Connectivity {}

void main() {
  late MockNetworkBloc mockNetworkBloc;

  setUp(() {
    mockNetworkBloc = MockNetworkBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<NetworkBloc>.value(
          value: mockNetworkBloc,
          child: const OfflineNotificationBanner(),
        ),
      ),
    );
  }

  group('OfflineNotificationBanner', () {
    testWidgets('renders banner when state is NetworkOffline', (WidgetTester tester) async {
      // Stub the state stream
      whenListen(
        mockNetworkBloc,
        Stream.fromIterable([NetworkOffline()]),
        initialState: NetworkOffline(), // Ensure initial state is also offline
      );

      await tester.pumpWidget(createWidgetUnderTest());
      
      // Let BLoCBuilder receive the state
      await tester.pump(); 

      expect(find.byType(MaterialBanner), findsOneWidget);
      expect(find.text('You are currently offline. Please check your internet connection.'), findsOneWidget);
      expect(find.byIcon(Icons.signal_wifi_off), findsOneWidget);
    });

    testWidgets('does not render banner when state is NetworkOnline', (WidgetTester tester) async {
      // Stub the state stream
       whenListen(
        mockNetworkBloc,
        Stream.fromIterable([NetworkOnline()]),
        initialState: NetworkOnline(), // Ensure initial state is online
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(MaterialBanner), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget); // Expects SizedBox.shrink()
    });
    
    testWidgets('hides banner when state changes from NetworkOffline to NetworkOnline', (WidgetTester tester) async {
      whenListen(
        mockNetworkBloc,
        Stream.fromIterable([NetworkOffline(), NetworkOnline()]), // Sequence of states
        initialState: NetworkOffline(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      
      // Initial state: Offline - Banner should be visible
      await tester.pump();
      expect(find.byType(MaterialBanner), findsOneWidget);

      // State changes to Online - Banner should disappear
      await tester.pump(); // Let BLoCBuilder rebuild for NetworkOnline
      expect(find.byType(MaterialBanner), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('shows banner when state changes from NetworkOnline to NetworkOffline', (WidgetTester tester) async {
       whenListen(
        mockNetworkBloc,
        Stream.fromIterable([NetworkOnline(), NetworkOffline()]), // Sequence of states
        initialState: NetworkOnline(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      // Initial state: Online - Banner should be hidden
      await tester.pump();
      expect(find.byType(MaterialBanner), findsNothing);

      // State changes to Offline - Banner should appear
      await tester.pump(); // Let BLoCBuilder rebuild for NetworkOffline
      expect(find.byType(MaterialBanner), findsOneWidget);
      expect(find.text('You are currently offline. Please check your internet connection.'), findsOneWidget);
    });
  });
}
