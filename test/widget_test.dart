// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ln_foot/service.dart'; // Import AuthService
import 'package:ln_foot/main.dart';

void main() {
  // Instantiate AuthService for the test
  final authService = AuthService();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Provide the required authService instance to MyApp
    await tester.pumpWidget(MyApp(authService: authService));

    // Verify that our counter starts at 0.
    // Note: This part of the test will likely fail now because
    // the default screen is SplashScreen, not the counter app.
    // This test should be updated or removed if it's no longer relevant.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
