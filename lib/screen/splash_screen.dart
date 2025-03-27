import 'dart:async'; // Import async library for Timer
import 'package:flutter/material.dart';
import 'package:ln_foot/screen/onboarding_screen.dart'; 

class SplashScreen extends StatefulWidget { 
  const SplashScreen({super.key});

  
  static const Color splashBlue = Color(0xFF2A5298); 

  @override
  State<SplashScreen> createState() => _SplashScreenState(); 
}

class _SplashScreenState extends State<SplashScreen> { 
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () { 
    
      Navigator.of(context).pushReplacement( 
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SplashScreen.splashBlue, // Access color via class name
      body: Center(
        child: Image.asset(
          'images/LNFOOT2 1.png', // Path to your logo image
          width: 150, // Adjust size as needed
        ),
      ),
    );
  }
}
