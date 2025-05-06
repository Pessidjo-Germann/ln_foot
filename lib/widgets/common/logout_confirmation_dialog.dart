import 'package:flutter/material.dart';
import '../custom_button.dart'; // Assuming CustomButton is here based on info.txt

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const LogoutConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery for responsive padding and potential theme access
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
   // final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor, // Or specific background color if needed
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Make column height fit content
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch items horizontally
        children: [
          // Optional: Add a drag handle indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),

          // Title
          Text(
            'Déconnexion',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold), // Adjust style as needed
          ),
          const SizedBox(height: 16.0),

          // Divider
          const Divider(thickness: 0.4),
          const SizedBox(height: 16.0),

          // Confirmation Message
          Text(
            'Etes vous sur de vouloir vous déconnecter ?', // Corrected typo
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge, // Adjust style as needed
          ),
          const SizedBox(height: 24.0),

          // Action Buttons
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: CustomButton(
                  text: 'Annulé',
                  onPressed: onCancel,
                  // Assuming CustomButton has styling options
                  // Use light/grey style for cancel
                  // Example: buttonStyle: ButtonStyle(backgroundColor: ...)
                  // Or maybe a specific constructor/parameter like isSecondary: true
                  // Adapt based on actual CustomButton implementation
                  // For now, let's assume default or provide basic styling
                  buttonColor: Colors.grey[200], // Use buttonColor parameter
                  textColor: Colors.black87,         // Example color
                ),
              ),
              const SizedBox(width: 16.0), // Spacing between buttons

              // Confirm Button
              Expanded(
                child: CustomButton(
                  text: 'Oui, Déconnexion',
                  onPressed: onConfirm,
                  // Use primary/red style for confirm
                  buttonColor: Colors.red, // Use buttonColor parameter
                  textColor: Colors.white,     // Example color
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0), // Bottom padding
        ],
      ),
    );
  }
}

// Example Usage (How you might show it using showModalBottomSheet):

void showLogoutDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Important for content-sized bottom sheets
    backgroundColor: Colors.transparent, // Make sheet background transparent
    builder: (BuildContext bc) {
      return LogoutConfirmationDialog(
        onConfirm: () {
          // Handle logout logic
          Navigator.of(context).pop(); // Close bottom sheet
          print("Logout confirmed");
        },
        onCancel: () {
          Navigator.of(context).pop(); // Close bottom sheet
          print("Logout cancelled");
        },
      );
    },
  );
}

