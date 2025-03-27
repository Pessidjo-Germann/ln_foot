import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ln_foot/screen/email_signup_screen.dart'; // To navigate to email signup
import 'package:ln_foot/screen/login_options_screen.dart'; // To navigate back to login

class SignupOptionsScreen extends StatelessWidget {
  const SignupOptionsScreen({super.key});

  // Define the orange color
  static const Color buttonOrange = Color(0xFFF9703B);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // Use leading back button to pop the current screen
        leading: IconButton(
           icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
           onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Inscription sur LNSHOP', // Title changed to Sign Up
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Google Sign Up Button
              OutlinedButton.icon(
                icon: Image.asset('images/google icon.png', height: 20.0), // Placeholder - Requires google icon asset
                label: const Text('S\'inscrire avec Google'), // Text changed
                onPressed: () {
                  // TODO: Implement Google Sign Up
                  print('Google Sign Up pressed');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Apple Sign Up Button
              OutlinedButton.icon(
                icon: const Icon(Icons.apple, color: Colors.black),
                label: const Text('S\'inscrire avec Apple'), // Text changed
                onPressed: () {
                  // TODO: Implement Apple Sign Up
                  print('Apple Sign Up pressed');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Divider with "Ou"
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Ou',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 32),

              // Email Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to Email Signup Screen
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EmailSignupScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Inscription par mail', // Text changed
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(), // Pushes the login text to the bottom

              // Login Text
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Vous avez déjà un compte? ', // Text changed
                    style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Connectez-vous', // Text changed
                        style: const TextStyle(
                          color: buttonOrange,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate back to Login Options Screen
                            // Check if LoginOptionsScreen is already in the stack to avoid duplicates
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context); // Pop current (SignupOptions) screen
                            } else {
                              // If it's the first screen (e.g., deep link), push LoginOptions
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginOptionsScreen()),
                              );
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
