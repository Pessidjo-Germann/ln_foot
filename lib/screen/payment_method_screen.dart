import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:ln_foot/screen/add_card_screen.dart'; // Import the AddCardScreen

import '../widgets/custom_button.dart';
import '../widgets/payment/saved_card_item.dart'; // Import the new widget
// TODO: Import widget for add card button

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedCardId; // To keep track of the selected card

  // TODO: Replace with actual card data fetching logic
  final List<Map<String, dynamic>> _savedCards = [
    {'id': '1', 'brand': 'VISA', 'last4': '2512', 'isDefault': true},
    {
      'id': '2',
      'brand': 'Mastercard',
      'last4': '5421',
      'isDefault': false
    }, // Assuming Mastercard based on logo
    {'id': '3', 'brand': 'VISA', 'last4': '2512', 'isDefault': false},
    {'id': '4', 'brand': 'VISA', 'last4': '2512', 'isDefault': false},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize selection with the default card
    _selectedCardId = _savedCards.firstWhere((card) => card['isDefault'])['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mode de paiement',
        showBackButton: true,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            icon: const Icon(Icons
                .notifications_none_outlined), // TODO: Use correct icon if available
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cartes enregistrées',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // TODO: Replace with SavedCardList widget
            Expanded(
              child: ListView.separated(
                itemCount: _savedCards.length,
                itemBuilder: (context, index) {
                  final card = _savedCards[index];
                  // Use the new SavedCardItem widget
                  return SavedCardItem(
                    id: card['id'],
                    brand: card['brand'],
                    last4: card['last4'],
                    isDefault: card['isDefault'],
                    selectedValue: _selectedCardId,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCardId = value;
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12), // Adjusted spacing
              ),
            ),
            const SizedBox(height: 20),
            // TODO: Refine into a dedicated AddNewCardButton widget later
            OutlinedButton.icon(
              icon: const Icon(Icons.add, size: 20, color: Colors.black),
              label: const Text('Ajouter une nouvelle carte'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: Colors.black, // Text/Icon color
                side: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withOpacity(0.5)), // Border color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0), // Match card item radius
                ),
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                // Navigate to the actual AddCardScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCardScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: 'Appliquer',
          onPressed: () {
            if (_selectedCardId != null) {
              // TODO: Handle apply action
              print('Applying card: $_selectedCardId');
              // Note: CustomButton might need internal logic
              // to appear visually disabled when _selectedCardId is null,
              // although this satisfies the type checker.
            }
          },
        ),
      ),
    );
  }
}

// Placeholder removed as AddCardScreen is now defined in its own file
