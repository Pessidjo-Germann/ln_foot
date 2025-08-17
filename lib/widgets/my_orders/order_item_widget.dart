import 'package:flutter/material.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/model/order_status.dart';
import 'package:lnFoot_api/api.dart';

class OrderItemWidget extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback? onReviewPressed;
  final VoidCallback? onTap;
  final OrderDto? orderDto; // Add the full order object for navigation

  const OrderItemWidget({
    super.key,
    required this.order,
    this.onReviewPressed,
    this.onTap,
    this.orderDto,
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
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
      ),
    );
  }

  Widget _buildStatusWidget(
      BuildContext context, String status, bool reviewed) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Parse the status to get OrderStatus enum
    final orderStatus = parseOrderStatus(status);

    switch (orderStatus) {
      case OrderStatus.created:
      case OrderStatus.paymentPending:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              orderStatus.displayName,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.orange[700],
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: onTap, // This will navigate to details where payment can be made
              style: ElevatedButton.styleFrom(
                backgroundColor: kAppOrangeColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              child: Text(
                'Payer',
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      
      case OrderStatus.paid:
      case OrderStatus.processing:
      case OrderStatus.shipped:
        return Padding(
          padding: const EdgeInsets.only(top: 28),
          child: Text(
            orderStatus.displayName,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.blue[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      
      case OrderStatus.delivered:
        return Padding(
          padding: const EdgeInsets.only(top: 28),
          child: Text(
            orderStatus.displayName,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      
      case OrderStatus.cancelled:
      case OrderStatus.failed:
        if (reviewed) {
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                orderStatus.displayName,
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: onReviewPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: 0.8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                child: Text(
                  'Avis',
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
    }
  }
}
