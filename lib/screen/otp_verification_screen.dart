import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ln_foot/screen/reset_password_screen.dart'; // To navigate to reset password
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
import 'package:pinput/pinput.dart'; // Import pinput

class OtpVerificationScreen extends StatefulWidget {
  final String email; // Receive email from previous screen

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState(); // Correctly defined createState
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> { // State class definition
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final focusNode = FocusNode(); // Optional: manage focus

  static const Color buttonOrange = Color(0xFFF9703B);

  @override
  void dispose() {
    _pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    // Always validate, even if using onChanged/onCompleted
    if (_formKey.currentState!.validate()) {
      print('Verifying OTP: ${_pinController.text} for email: ${widget.email}');
      // TODO: Implement actual OTP verification logic (API call)

      // On successful verification, navigate to ResetPasswordScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(), // Pass necessary data if needed
        ),
      );
    } else {
      print('OTP validation failed');
    }
  }

  void _resendCode() {
    print('Resending code to: ${widget.email}');
    // TODO: Implement resend code logic (API call)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code renvoyé')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Define the Pinput theme
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: buttonOrange),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.red),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Entrez le code à 4 chiffres'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Entrez le code à 4 chiffres que vous recevrez sur votre e-mail (${widget.email}).',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Pinput Field
                Directionality(
                  textDirection: TextDirection.ltr, // Ensure LTR for pin input
                  child: Pinput(
                    length: 4, // OTP length
                    controller: _pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    errorPinTheme: errorPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 16), // Space between boxes
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.length != 4) {
                        return 'Veuillez entrer le code à 4 chiffres';
                      }
                      // Add more specific OTP validation if needed
                      return null;
                    },
                    onCompleted: (pin) {
                      print('OTP Completed: $pin');
                      // Optionally trigger verification automatically on completion
                      // _verifyOtp();
                    },
                  ),
                ),
                const SizedBox(height: 40),

                // Verify Button
                CustomButton(
                  text: 'Confirmer',
                  onPressed: _verifyOtp,
                ),
                const SizedBox(height: 24),

                // Resend Code Text
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Email non reçu? ',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Renvoyer le code',
                          style: const TextStyle(
                            color: buttonOrange,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = _resendCode,
                        ),
                      ],
                    ),
                  ),
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
