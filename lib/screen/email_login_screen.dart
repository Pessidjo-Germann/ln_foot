import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/constante.dart';
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

  static const Color buttonOrange = Color(0xFFF9703B);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Basic email validation regex
  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

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
      showSuccessBottomSheet(context, "Fait","Connexion réussie");
    } else {
      print('Login failed: Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Connexion avec Email'),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre adresse mail';
                    }
                    if (!_isValidEmail(value)) {
                      return 'Veuillez entrer une adresse mail valide';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement Forgot Password flow
                      print('Forgot Password pressed');
                    },
                    child: const Text(
                      'Mot de passe oublié?',
                      style: TextStyle(color: buttonOrange),
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
