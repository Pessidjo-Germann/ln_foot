import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ln_foot/pages/offline_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Required for NetworkBloc if used, but not strictly for this page's UI
import 'package:ln_foot/blocs/network_bloc/network_bloc.dart'; // Required if OfflinePage directly interacts
import 'package:connectivity_plus/connectivity_plus.dart'; // For instantiating NetworkBloc if needed

// Mock NetworkBloc for testing purposes - even if OfflinePage doesn't directly listen,
// its context might expect it if it's part of a larger app structure.
// However, for isolated page testing, it might not be strictly necessary unless
// the Retry button directly interacts with it.
class MockNetworkBloc extends Bloc<NetworkEvent, NetworkState> implements NetworkBloc {
  MockNetworkBloc(NetworkState initialState) : super(initialState);
  // Mocking the constructor that takes Connectivity
  // factory MockNetworkBloc.withConnectivity({required Connectivity connectivity}) {
  //   return MockNetworkBloc(NetworkOffline()); // Default state
  // }
}


void main() {
  Widget createWidgetUnderTest() {
    // For testing OfflinePage in isolation, it doesn't strictly need NetworkBloc
    // unless its 'Retry' button directly dispatches an event.
    // The current OfflinePage's retry button shows a SnackBar and doesn't dispatch.
    // If it did, we'd need to provide NetworkBloc.
    return const MaterialApp(
      home: OfflinePage(),
    );
  }
  
  // If the Retry button were to interact with NetworkBloc:
  Widget createWidgetUnderTestWithBloc() {
    final mockConnectivity = Connectivity(); // Or a proper mock if methods are called
    return MaterialApp(
      home: BlocProvider<NetworkBloc>(
        create: (_) => NetworkBloc(connectivity: mockConnectivity), // Provide the actual BLoC or a mock
        child: const OfflinePage(),
      ),
    );
  }


  group('OfflinePage', () {
    testWidgets('renders correctly with all expected elements', (WidgetTester tester) async {
      // Use createWidgetUnderTest() if no BLoC interaction from Retry button.
      // Use createWidgetUnderTestWithBloc() if Retry button needs NetworkBloc in context.
      // Given the current implementation of OfflinePage (Retry shows SnackBar),
      // createWidgetUnderTest() is sufficient.
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify AppBar title
      expect(find.widgetWithText(AppBar, 'Offline'), findsOneWidget);

      // Verify Icon
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);

      // Verify primary text
      expect(find.text('You are offline'), findsOneWidget);

      // Verify secondary text
      expect(find.text('Please check your internet connection and try again.'), findsOneWidget);

      // Verify Retry button by text
      expect(find.widgetWithText(ElevatedButton, 'Retry Connection'), findsOneWidget);
      
      // Verify Retry button by icon
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Retry button can be tapped (basic interaction)', (WidgetTester tester) async {
      // For this test, if the Retry button needed a BLoC to dispatch an event,
      // we would use createWidgetUnderTestWithBloc().
      // Since it currently shows a SnackBar, it needs a ScaffoldMessenger ancestor.
      // MaterialApp provides one.
      await tester.pumpWidget(createWidgetUnderTest());

      final retryButton = find.widgetWithText(ElevatedButton, 'Retry Connection');
      expect(retryButton, findsOneWidget);

      await tester.tap(retryButton);
      await tester.pumpAndSettle(); // For SnackBar to appear and settle

      // Verify SnackBar appears (or any other action if implemented)
      // For now, it shows a SnackBar with "Checking for connection... (Not implemented yet)"
      expect(find.text('Checking for connection... (Not implemented yet)'), findsOneWidget);
    });
  });
}
