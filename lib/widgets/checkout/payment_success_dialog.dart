import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/custom_button.dart'; // Assuming CustomButton exists

class PaymentSuccessDialog extends StatelessWidget {
  final VoidCallback onTrackOrderPressed;

  const PaymentSuccessDialog({
    super.key,
    required this.onTrackOrderPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(24), // Consistent padding
      content: Column(
        mainAxisSize: MainAxisSize.min, // Fit content height
        children: [
          // Success Icon (Green Checkmark in a Circle)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade100, // Light green background
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.green, // Darker green checkmark
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          // Title Text
          Text(
            'Félicitations!',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Subtitle Text
          Text(
            'Votre commande a été passée.',
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          // Track Order Button
          CustomButton(
            text: 'Suivez votre commande',
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog first
              onTrackOrderPressed(); // Then call the callback
            },
            // Optional: Add specific styling if needed for this button
          ),
          const SizedBox(height: 8), // Small padding at the bottom
        ],
      ),
    );
  }
}
