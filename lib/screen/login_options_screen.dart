import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ln_foot/screen/email_login_screen.dart';
import 'package:ln_foot/screen/signup_options_screen.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
import 'package:ln_foot/widgets/social_button.dart';

class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({super.key});

  // Removed local buttonOrange definition

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Connexion sur LNSHOP',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SocialButton(
                icon: Image.asset('images/google icon.png', height: 20.0),
                text: 'S\'inscrire avec Google',
                onPressed: () {
                  print('Google Sign Up pressed');
                },
              ),
              const SizedBox(height: 16),

// Apple Button
              SocialButton(
                icon: const Icon(Icons.apple, color: Colors.black),
                text: 'S\'inscrire avec Apple',
                onPressed: () {
                  print('Apple Sign Up pressed');
                },
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
                      style: textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 32),

              CustomButton(
                text: 'Connexion par mail',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EmailLoginScreen()),
                  );
                },
              ),
              const Spacer(),

              // Sign Up Text
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Vous n\'avez pas de compte? ',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: Colors.grey.shade600),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Inscrivez-vous',
                        style: const TextStyle(
                          color: kAppOrangeColor, // Use theme color
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignupOptionsScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
