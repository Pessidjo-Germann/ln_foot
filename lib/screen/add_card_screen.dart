import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
// TODO: Potentially import CustomTextField if suitable

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          contentPadding: const EdgeInsets.all(24.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // TODO: Replace with actual checkmark asset if available
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green.shade100,
                child: const Icon(Icons.check, color: Colors.green, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                'Félicitations!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Votre nouvelle carte a été ajoutée.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomButton( // Reusing CustomButton
                text: 'Merci',
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back from AddCardScreen
                },
              )
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Nouveau Panier', 
        showBackButton: true,
        onBackButtonPressed: () => Navigator.of(context).pop(),
         actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined), // Consistent with previous screen
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ajouter une carte de débit ou de crédit', // Using French text from 3rd image
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24.0),

              // Card Number Field
              Text('Numéro de carte', style: textTheme.labelLarge),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  hintText: '**** **** **** ****',
                  // TODO: Add card icon prefix if needed
                  // TODO: Apply theme border/style
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(19), // Max length for card number + spaces
                  _CardNumberInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty || value.replaceAll(' ', '').length < 13) { // Basic check
                    return 'Numéro de carte invalide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expiry Date Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date d\'expiration', style: textTheme.labelLarge),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _expiryDateController,
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          keyboardType: TextInputType.number,
                           inputFormatters: [
                             FilteringTextInputFormatter.digitsOnly,
                             LengthLimitingTextInputFormatter(4),
                             _CardExpiryInputFormatter(),
                           ],
                           validator: (value) {
                             if (value == null || value.isEmpty || value.length < 4) {
                               return 'Date invalide';
                             }
                             // TODO: Add more robust date validation
                             return null;
                           },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),

                  // Security Code Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Code de sécurité', style: textTheme.labelLarge),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _cvcController,
                          decoration: InputDecoration(
                            hintText: 'CVC',
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            suffixIcon: IconButton( // Help icon
                                icon: Icon(Icons.help_outline, color: colorScheme.outline),
                                onPressed: () {
                                  // TODO: Show CVC help tooltip/dialog
                                },
                              )
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4), // CVC/CVV max length
                          ],
                           validator: (value) {
                             if (value == null || value.isEmpty || value.length < 3) {
                               return 'Code invalide';
                             }
                             return null;
                           },
                           obscureText: true, // Hide CVC
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
       bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: 'Ajouter une carte',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // TODO: Process card addition (e.g., API call)
              print('Card Number: ${_cardNumberController.text}');
              print('Expiry Date: ${_expiryDateController.text}');
              print('CVC: ${_cvcController.text}');
              // Simulate success
              _showSuccessDialog();
            }
          },
        ),
      ),
    );
  }
}


// Input Formatter for Card Number (adds spaces)
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(' ', '');
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Add space after every 4 digits
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// Input Formatter for Expiry Date (adds '/')
class _CardExpiryInputFormatter extends TextInputFormatter {
 @override
 TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('/', '');
    var buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) {
         buffer.write('/'); // Add slash after MM
      }
    }

    var string = buffer.toString();
     // Ensure cursor is at the end
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
