import 'package:flutter/material.dart';
import 'package:ln_foot/screen/forgot_password_screen.dart'; // Import forgot password screen
import 'package:ln_foot/theme/app_theme.dart'; // Import theme
import 'package:ln_foot/utils/bottom_sheet_utils.dart';
import 'package:ln_foot/utils/validators.dart'; // Import validators
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
import 'package:ln_foot/widgets/custom_text_field.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _autovalidate = false;

  // Removed local buttonOrange definition

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Removed local _isValidEmail function

  void _login() {
    setState(() {
      _autovalidate = true; // Start validating fields
    });
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with login logic
      print('Login successful!');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      // Show success dialog
      showSuccessBottomSheet(context,
          title: "Fait", buttonText: "Connexion réussie", onPressed: () {
        Navigator.of(context).pop();
      });
    } else {
      print('Login failed: Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
          title: 'Connexion avec Email', showBackButton: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Entrez votre email',
                  validator:
                      Validators.validateEmail, // Use centralized validator
                ),
                const SizedBox(height: 24),

                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Mot de passe',
                  hintText: 'Entrer votre mot de passe',
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  // Use centralized validator for required field
                  validator: (value) =>
                      Validators.validateRequired(value, 'votre mot de passe'),
                ),
                const SizedBox(height: 16),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to Forgot Password Screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Mot de passe oublié?',
                      style:
                          TextStyle(color: kAppOrangeColor), // Use theme color
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                CustomButton(
                  text: 'Se connecter',
                  onPressed: _login,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
