import 'package:flutter/material.dart';
import 'package:ln_foot/theme/app_theme.dart';

class OrderItemWidget extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback? onReviewPressed;

  const OrderItemWidget({
    super.key,
    required this.order,
    this.onReviewPressed,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        order['image'] ?? 'images/placeholder.png'; // Handle missing image
    final String name = order['name'] ?? 'Nom du produit';
    final String size = order['size'] ?? '';
    final String price = order['price'] ?? 'Prix inconnu';
    final String status = order['status'] ?? 'unknown';
    final bool reviewed =
        order['reviewed'] ?? false; // Specific to 'review' status

    // Use theme for consistent styling
    final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the top
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                // Consider using Image.network if URLs are used
                imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                // Add error builder for robustness
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey[200],
                  child:
                      Icon(Icons.image_not_supported, color: Colors.grey[400]),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (size.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(size,
                        style: textTheme.bodySmall
                            ?.copyWith(color: Colors.grey[600])),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Status/Action Widget
            _buildStatusWidget(context, status, reviewed),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWidget(
      BuildContext context, String status, bool reviewed) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case 'ongoing':
        return Padding(
          padding: const EdgeInsets.only(top: 28),
          child: const Text(
            'suivi de commande',
            textAlign: TextAlign.center,
            style: TextStyle(color: kAppOrangeColor),
          ),
        );
      case 'completed':
        return Padding(
          // Add padding for alignment
          padding: const EdgeInsets.only(top: 28),
          child: Text(
            'Livré',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case 'review':
        if (reviewed) {
          // For reviewed items, just show text instead of a button
          return InkWell(
            onTap: onReviewPressed,
            child: Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Text(
                "Voir l'avis",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          );
        } else {
          // For non-reviewed items, keep the button
          return ElevatedButton(
            onPressed: onReviewPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF16A26).withOpacity(0.8),
                foregroundColor: colorScheme.onTertiaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                textStyle: textTheme.labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            child: const Text('Revoir'),
          );
        }
      default:
        return const SizedBox.shrink(); // Handle unknown status
    }
  }
}
