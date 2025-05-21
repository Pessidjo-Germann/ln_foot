// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:ln_foot/screen/email_signup_screen.dart'; // To navigate to email signup
// import 'package:ln_foot/screen/login_options_screen.dart'; // To navigate back to login
// import 'package:ln_foot/theme/app_theme.dart';
// import 'package:ln_foot/widgets/custom_app_bar.dart';
// import 'package:ln_foot/widgets/social_button.dart'; // Import theme

// class SignupOptionsScreen extends StatelessWidget {
//   const SignupOptionsScreen({super.key});

//   // Removed local buttonOrange definition

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: 'Inscription sur LNSHOP',
//         showBackButton: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Google Sign Up Button
//               SocialButton(
//                 icon: Image.asset('images/google icon.png', height: 20.0),
//                 text: 'S\'inscrire avec Google',
//                 onPressed: () {
//                   print('Google Sign Up pressed');
//                 },
//               ),
//               const SizedBox(height: 16),

// // Apple Button
//               SocialButton(
//                 icon: const Icon(Icons.apple, color: Colors.black),
//                 text: 'S\'inscrire avec Apple',
//                 onPressed: () {
//                   print('Apple Sign Up pressed');
//                 },
//               ),
//               const SizedBox(height: 32),

//               // Divider with "Ou"
//               Row(
//                 children: [
//                   Expanded(child: Divider(color: Colors.grey.shade300,thickness: 0.4)),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       'Ou',
//                       style: textTheme.bodyMedium
//                           ?.copyWith(color: Colors.grey.shade600),
//                     ),
//                   ),
//                   Expanded(child: Divider(color: Colors.grey.shade300,thickness: 0.4)),
//                 ],
//               ),
//               const SizedBox(height: 32),

//               // Email Sign Up Button
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to Email Signup Screen
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const EmailSignupScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       kAppOrangeColor, // Use theme color (Consider kPrimaryColor if it should match other main buttons)
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   textStyle: textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 child: const Text(
//                   // Restore the child
//                   'Inscription par mail', // Text changed
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               const Spacer(), // Pushes the login text to the bottom

//               // Login Text
//               Center(
//                 child: RichText(
//                   text: TextSpan(
//                     text: 'Vous avez déjà un compte? ', // Text changed
//                     style: textTheme.bodyMedium
//                         ?.copyWith(color: Colors.grey.shade600),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: 'Connectez-vous', // Text changed
//                         style: const TextStyle(
//                           color: kAppOrangeColor, // Use theme color
//                           fontWeight: FontWeight.bold,
//                           decoration: TextDecoration.underline,
//                         ),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             // Navigate back to Login Options Screen
//                             // Check if LoginOptionsScreen is already in the stack to avoid duplicates
//                             if (Navigator.canPop(context)) {
//                               Navigator.pop(
//                                   context); // Pop current (SignupOptions) screen
//                             } else {
//                               // If it's the first screen (e.g., deep link), push LoginOptions
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const LoginOptionsScreen()),
//                               );
//                             }
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16), // Bottom padding
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
