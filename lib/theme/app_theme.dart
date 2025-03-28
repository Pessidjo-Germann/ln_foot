import 'package:flutter/material.dart';

// Color Constants
const Color kPrimaryColor = Color.fromARGB(255, 41, 74, 240);
const Color kAppOrangeColor =
    Color(0xFFF9703B); // Specific orange for links/highlights
// Add other colors as needed, e.g., kSecondaryColor, kTextColor, kBackgroundColor

// ThemeData
final ThemeData appThemeData = ThemeData(
  primaryColor: kAppOrangeColor,
  scaffoldBackgroundColor: Colors.white, // Assuming a white background
  colorScheme: ColorScheme.light(
    primary: kAppOrangeColor,
    secondary: kPrimaryColor, // Define if needed
    // Add other color scheme properties
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white, // Or kPrimaryColor depending on design
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: kAppOrangeColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Based on image radius
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kAppOrangeColor,
      foregroundColor: Colors.white, // Text color on button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Based on image radius
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 14.0, horizontal: 16.0), // Based on image padding
      textStyle: const TextStyle(
        fontSize: 16, // Adjust as needed
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0), // Based on image radius
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
          color: kPrimaryColor), // Highlight focus with primary color
    ),
    contentPadding: const EdgeInsets.symmetric(
        vertical: 14.0, horizontal: 16.0), // Based on image padding
  ),
  // Define other theme properties like textTheme if needed
  // textTheme: const TextTheme(
  //   headlineLarge: TextStyle(...),
  //   bodyMedium: TextStyle(...),
  // ),
);
