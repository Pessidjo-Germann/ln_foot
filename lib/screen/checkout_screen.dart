import 'package:flutter/material.dart';
import 'package:ln_foot/screen/add_card_screen.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
// Import the newly created widgets
import 'package:ln_foot/widgets/checkout/address_section.dart';
import 'package:ln_foot/widgets/checkout/payment_method_section.dart';
import 'package:ln_foot/widgets/checkout/order_summary_section.dart';
import 'package:ln_foot/widgets/checkout/payment_success_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        // Use the dedicated PaymentSuccessDialog widget
        return PaymentSuccessDialog(
          onTrackOrderPressed: () {
            // TODO: Implement actual navigation to order tracking screen
            print("Navigate to track order screen");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Replace placeholders with actual widgets
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Vérification',
        onBackButtonPressed: Navigator.of(context).pop,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined), // Placeholder icon
            onPressed: () {
          
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use AddressSection Widget
            AddressSection(
              addressType: 'Maison', // Example data
              fullAddress: '925 S Chugach St #APT 10, Alaska 99645', // Example data
              onChangePressed: () {
                // TODO: Implement address change logic
                print("Change address pressed");
              },
            ),
            const SizedBox(height: 24),

            // Use PaymentMethodSection Widget
            PaymentMethodSection(
              onEditCardPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddCardScreen()),
              // TODO: Pass actual payment methods, selected card details etc.
            )),
            const SizedBox(height: 24),

            // Use OrderSummarySection Widget
            OrderSummarySection(
              subtotal: 170.75, // Example data
              shippingFee: 20.00, // Example data
              discount: 10.00, // Example data
              total: 180.99, // Example data
            ),
            const SizedBox(height: 30), // Space before bottom button
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton( // Using existing CustomButton
          text: 'Passer la commande',
          onPressed: _showSuccessDialog, // Show dialog on press
        ),
      ),
    );
  }

  // --- Placeholder build methods removed ---
}
