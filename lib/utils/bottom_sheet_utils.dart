import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/custom_button.dart';

/// Shows a standardized success message bottom sheet.
///
/// [context]: The build context.
/// [title]: The main message/title displayed prominently.
/// [buttonText]: The text for the action button.
/// [onPressed]: The callback function executed when the button is pressed.
void showSuccessBottomSheet(
  BuildContext context, {
  required String title,
  required String buttonText,
  required VoidCallback onPressed,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Allows the sheet to take up more screen height if needed
    shape: const RoundedRectangleBorder(
      // Consistent rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      // Use DraggableScrollableSheet for flexible height based on content
      return DraggableScrollableSheet(
        expand:
            false,  
        initialChildSize: 0.4,  
        minChildSize: 0.3, // Minimum size when dragging down
        maxChildSize: 0.7, // Maximum size when dragging up
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              // Consistent padding
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Take minimum vertical space
                children: [
                  const SizedBox(height: 20),
                  // Consider making the image path a parameter if different success images are needed
                  Image.asset(
                    'images/checkmark-circle-02.png',
                    height: 100, // Maintain image size
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight:
                                  FontWeight.bold, // Example: Use theme style
                            ) ??
                        const TextStyle(
                          // Fallback style
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Ensure the button stretches horizontally
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: buttonText,
                      onPressed: onPressed,
                    ),
                  ),
                  const SizedBox(height: 16), // Added padding at the bottom
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
