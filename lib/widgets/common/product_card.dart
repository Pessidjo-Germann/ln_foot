import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lnFoot_api/api.dart'; // Use ProductDto from API

class ProductCard extends StatelessWidget {
  final ProductDto product; // Change type to ProductDto
  final VoidCallback? onTap;
  // final VoidCallback? onFavoriteTap; // Remove favorite tap for now

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    // this.onFavoriteTap, // Remove favorite tap for now
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'fr_CM',
      symbol: '',
      decimalDigits: 0,
    );
    final NumberFormat oldPriceNumberFormatter =
        NumberFormat.decimalPattern('fr_CM');
    print(product.imageUrl);
    return GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 1.5,
          shadowColor: Colors.grey.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            
            margin: const EdgeInsets.only(bottom: 1.0),  
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,  
              children: [
                
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(16.0),
                      ),
                      // Use Image.network for URLs, handle null
                      child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                          ? Image.network( // Use Image.network
                              product.imageUrl!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 120, // Match image height
                                  color: Colors.grey.shade200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 120, // Match image height
                                color: Colors.grey.shade200,
                                child: Icon(Icons.broken_image, color: Colors.grey.shade400, size: 40),
                              ),
                            )
                          : Container( // Placeholder if no image URL
                              height: 120,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.image_not_supported, color: Colors.grey.shade400, size: 40),
                            ),
                    ),
                    // Favorite button removed for now
                  ],
                ),

                // Details Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0), // Adjusted padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Use product name as title, handle null
                      Text(
                        product.name ?? 'Unnamed Product', // Use name from DTO
                        style: theme.textTheme.titleMedium?.copyWith( // Adjusted style slightly
                          fontWeight: FontWeight.w600, // Slightly bolder
                          color: Colors.black87,
                        ),
                        maxLines: 2, // Allow two lines for name
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4), // Spacing
                      // Display categories if available
                      if (product.categoryNames.isNotEmpty)
                        Text(
                          product.categoryNames.join(', '), // Join categories
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 8), // Spacing
                      // Price Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${currencyFormatter.format(product.price)} Fcfa', // Use price from DTO
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          // Old price removed
                        ],
                      ),
                      // Rating section removed
                    ], // Closes children list for inner Column
                  ), // Closes inner Column
                ), // Closes Padding
              ], // Closes children list for outer Column
            ), // Closes outer Column
          ), // Closes SizedBox
        )); // Closes Card
  }
}
