import 'package:flutter/material.dart';

enum PaymentMethod { card, cash, other }

class PaymentMethodSection extends StatefulWidget {
  // TODO: Add parameters for initial selection, available methods, card details, etc.
  final VoidCallback onEditCardPressed;

  const PaymentMethodSection({
    super.key,
    required this.onEditCardPressed,
  });

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  PaymentMethod _selectedMethod = PaymentMethod.card; // Default selection

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          'Mode de paiement',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Payment Method Selector Row
        Row(
          children: [
            _buildPaymentMethodButton(
              context,
              icon: Icons.credit_card_outlined,
              label: 'Carte',
              method: PaymentMethod.card,
            ),
            const SizedBox(width: 12),
            _buildPaymentMethodButton(
              context,
              icon: Icons.money_outlined,
              label: 'Cash',
              method: PaymentMethod.cash,
            ),
            const SizedBox(width: 12),
            _buildPaymentMethodButton(
              context,
              // Placeholder for the third payment icon (e.g., mobile money)
              icon: Icons.phone_android, // Example icon
              label: 'Autre', // Example label
              method: PaymentMethod.other,
              // TODO: Replace with actual icon/image if available
              isPlaceholder: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Selected Card Details (only shown if card is selected)
        if (_selectedMethod == PaymentMethod.card) _buildSelectedCardDetails(context),
      ],
    );
  }

  Widget _buildPaymentMethodButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required PaymentMethod method,
    bool isPlaceholder = false, // Flag for placeholder image/icon
  }) {
    final bool isSelected = _selectedMethod == method;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final unselectedColor = Colors.grey.shade600;
    final selectedBgColor = primaryColor.withOpacity(0.1);
    final unselectedBgColor = Colors.grey.shade200;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedMethod = method;
          });
          // TODO: Add callback if needed when selection changes
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? selectedBgColor : unselectedBgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? primaryColor : unselectedColor,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? primaryColor : unselectedColor,
                ),
              ),
              // TODO: If using an image instead of icon for the 3rd option:
              // isPlaceholder ? Image.asset('path/to/image', height: 20, width: 20) : Icon(...)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedCardDetails(BuildContext context) {
    // Placeholder for selected card details
    // TODO: Fetch actual card details (last 4 digits, type)
    const cardType = 'VISA';
    const last4Digits = '2512';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Placeholder for Card Icon (e.g., VISA logo)
          // TODO: Use actual card brand icon if available
          const Icon(Icons.credit_card, size: 28, color: Colors.black87), // Generic icon
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$cardType **** **** **** $last4Digits',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5, // Add spacing for card number look
              ),
            ),
          ),
          InkWell(
            onTap: widget.onEditCardPressed,
            child: Icon(
              Icons.edit_outlined,
              color: Colors.grey.shade600,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
