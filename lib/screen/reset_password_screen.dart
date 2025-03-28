import 'package:flutter/material.dart';
import 'package:ln_foot/screen/login_options_screen.dart'; // To navigate back to login after success
import 'package:ln_foot/widgets/constante.dart'; // Import custom bottom sheet
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
import 'package:ln_foot/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  // Optionally receive email or token if needed for the API call
  // final String email;
  // final String otpToken;

  const ResetPasswordScreen({
    super.key,
    // required this.email,
    // required this.otpToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _autovalidate = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    setState(() {
      _autovalidate = true;
    });
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with password reset logic
      print('Resetting password...');
      print('New Password: ${_newPasswordController.text}');
      // TODO: Implement actual password reset logic (API call with email/token)

      // Show success bottom sheet
      showSuccessBottomSheet(
        context,
        'Continuer à vous connecter', // Button text
        'Mot de passe mis à jour avec succès !', // Message text
      );

      // After the bottom sheet is dismissed (by pressing the button), navigate back to login
      // We might need to adjust showSuccessBottomSheet or handle navigation differently
      // For now, let's assume the button press in the sheet handles dismissal only.
      // We can navigate after the sheet is shown.
      // A better approach might be to pass a callback to showSuccessBottomSheet.
      // Let's navigate after a short delay or directly after showing the sheet for simplicity now.

      // Navigate back to the login options screen, clearing the stack until then.
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => const LoginOptionsScreen()),
      //   (Route<dynamic> route) => false, // Remove all previous routes
      // );
    } else {
      print('Password reset failed: Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Créer un nouveau mot de passe'),
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
                // New Password Field
                CustomTextField(
                  controller: _newPasswordController,
                  labelText: 'Nouveau mot de passe',
                  hintText: 'Entrer votre nouveau mot de passe',
                  helperText: 'Password Minimum of 8 characters',
                  isPassword: true,
                  isPasswordVisible: _isNewPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nouveau mot de passe';
                    }
                    if (value.length < 8) {
                      return 'Le mot de passe doit contenir au moins 8 caractères';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Confirm New Password Field
                CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirmer le mot de passe',
                  hintText: 'Confirmer le nouveau mot de passe',
                  isPassword: true,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer le nouveau mot de passe';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Reset Password Button
                CustomButton(
                  text: 'Mettre à jour le mot de passe',
                  onPressed: _resetPassword,
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
