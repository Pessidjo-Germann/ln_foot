import 'package:flutter/material.dart';
import 'package:ln_foot/screen/otp_verification_screen.dart'; // To navigate to OTP screen
import 'package:ln_foot/utils/validators.dart'; // Import validators
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
import 'package:ln_foot/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _autovalidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Removed local _isValidEmail function

  void _sendCode() {
    setState(() {
      _autovalidate = true;
    });
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed to send code and navigate
      print('Sending code to: ${_emailController.text}');
      // TODO: Implement actual code sending logic (API call)

      // Navigate to OTP screen, passing the email
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(email: _emailController.text),
        ),
      );
    } else {
      print('Email validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Mot de passe oublié'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Entrez votre identifiant e-mail pour le processus de vérification, nous vous enverrons 4 chiffres à votre adresse e-mail',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Email Field
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Entrez votre email',
                  validator: Validators.validateEmail, // Use centralized validator
                ),
                const SizedBox(height: 40),
                // Send Code Button
                CustomButton(
                  text: 'Envoyer le Code', // Changed text based on image
                  onPressed: _sendCode,
                ),
                const Spacer(), // Pushes content up
              ],
            ),
          ),
        ),
      ),
    );
  }
}
