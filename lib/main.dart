import 'package:flutter/material.dart';
import 'package:ln_foot/screen/splash_screen.dart'; // Import the splash screen
import 'package:ln_foot/theme/app_theme.dart'; // Import the theme

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LN Foot', // Changed title
      theme: appThemeData, // Use the imported theme data
      home: const SplashScreen(), // Set SplashScreen as home
      debugShowCheckedModeBanner: false, // Optional: Remove debug banner
    );
  }
}

// Removed the default MyHomePage widget and related code
