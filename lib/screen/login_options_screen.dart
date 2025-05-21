import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:lnFoot_api/api.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart'; // Import AuthBloc
import 'package:ln_foot/screen/email_login_screen.dart';
import 'package:ln_foot/screen/home_screen.dart'; // Import HomeScreen for navigation
import 'package:ln_foot/screen/signup_options_screen.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
import 'package:ln_foot/widgets/social_button.dart';

class LoginOptionsScreen extends StatelessWidget {
  final ApiClient apiClient;
  const LoginOptionsScreen({super.key, required this.apiClient});

  // Removed local buttonOrange definition

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Connexion en cours...')),
              );
          } else if (state is Authenticated) {
            // Navigate to home screen on successful authentication
            context.read<AuthBloc>().add(CheckToken());
           
          }else if(state is AuthenticatedWithToken ){
            // Set the token in the ApiClient
            apiClient.setAuthToken(state.token);
            // Navigate to HomeScreen
             ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      const HomeScreen()), // Navigate to HomeScreen
              (Route<dynamic> route) => false, // Remove all previous routes
            );
          }
           else if (state is AuthError) {
            // Show error message
            debugPrint('AuthError: ${state.message}');
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text('Erreur de connexion: ${state.message}')),
              );
          }
        },
        child: Scaffold(
          // Original Scaffold is now a child of BlocListener
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            title: 'Connexion sur LNSHOP',
            showBackButton: false,
          ),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SocialButton(
                    icon: Image.asset('images/google icon.png', height: 20.0),
                    text:
                        'Se connecter avec Google', // Changed text slightly for clarity
                    onPressed: () {
                      // Dispatch LoginRequested event when Google button is pressed
                      context.read<AuthBloc>().add(LoginRequested());
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
                      Expanded(
                          child: Divider(
                              color: Colors.grey.shade300, thickness: 0.4)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Ou',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                              color: Colors.grey.shade300, thickness: 0.4)),
                    ],
                  ),
                  const SizedBox(height: 32),

                  CustomButton(
                    text: 'Connexion par mail',
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => const EmailLoginScreen()),
                      // );
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
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const SignupOptionsScreen()),
                                // );
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
        )); // End of Scaffold
  } // Add missing closing parenthesis for BlocListener
}
