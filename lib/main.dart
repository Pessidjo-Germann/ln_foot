import 'package:flutter/material.dart';
import 'package:ln_foot/screen/splash_screen.dart'; 
import 'package:ln_foot/theme/app_theme.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LN Foot', 
      theme: appThemeData,  
      home: const SplashScreen(), 
      debugShowCheckedModeBanner: false, 
    );
  }
}

 