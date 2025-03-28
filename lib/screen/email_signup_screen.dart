import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ln_foot/theme/app_theme.dart'; // Import theme
import 'package:ln_foot/utils/bottom_sheet_utils.dart';
import 'package:ln_foot/utils/validators.dart'; // Import validators
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart'; // Ensure this import is present

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;
  bool _autovalidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Removed local _isValidEmail function

  void _signup() {
    setState(() {
      _autovalidate =
          true; // Start validating fields on interaction after first attempt
    });
    // Also validate checkbox separately
    if (_formKey.currentState!.validate() && _acceptTerms) {
      // Form and checkbox are valid, proceed with signup logic
      print('Signup successful!');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      showSuccessBottomSheet(context,title: "Fait",buttonText:  "Inscription réussie",onPressed:  () {
                            Navigator.of(context).pop();
                          });
    } else {
      print('Signup failed: Form or terms invalid');
      // Optionally show a snackbar if terms not accepted
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Veuillez accepter les conditions générales')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Inscription avec Email'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Entrez votre email',
                    validator: Validators.validateEmail, // Use centralized validator
                  ),
                  const SizedBox(height: 24),

                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Mot de passe',
                    hintText: 'Entrez votre mot de passe',
                    helperText: 'Password Minimum of 8 characters',
                    isPassword: true,
                    isPasswordVisible: _isPasswordVisible,
                    onVisibilityToggle: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    validator: Validators.validatePassword, // Use centralized validator
                  ),
                  const SizedBox(height: 24),

                  CustomTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirmer le mot de passe',
                    hintText: 'Confirmer le mot de passe',
                    isPassword: true,
                    isPasswordVisible: _isConfirmPasswordVisible,
                    onVisibilityToggle: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    // Use centralized validator
                    validator: (value) => Validators.validateConfirmPassword(
                        value, _passwordController.text),
                  ),
                  const SizedBox(height: 24),

                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                        side: BorderSide(
                            color: _autovalidate && !_acceptTerms
                                ? Colors.red
                                : Colors
                                    .grey), // Highlight if not checked on submit
                      ),
                      Expanded(
                        // Use Expanded to allow text to wrap
                        child: RichText(
                          text: TextSpan(
                            text: 'Accepter ',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.black87),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Les conditions générales',
                                style: const TextStyle(
                                  color: kAppOrangeColor, // Use theme color
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Implement navigation/display of Terms and Conditions
                                    print('Navigate to Terms and Conditions');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_autovalidate &&
                      !_acceptTerms) // Show error message below checkbox if needed
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                      child: Text(
                        'Veuillez accepter les conditions générales',
                        style:
                            TextStyle(color: Colors.red.shade700, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 32),

                  CustomButton(
                    text: 'S\'inscrire',
                    onPressed: _signup,
                  ),
                  const SizedBox(height: 20), // Add bottom padding
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
