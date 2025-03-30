import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ln_foot/utils/bottom_sheet_review_all.dart';

import 'review_item.dart'; // For currency formatting

class ProductInfoSection extends StatelessWidget {
  final String name;
  final double price;
  final double rating;
  final int reviewCount;

  const ProductInfoSection({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    // Consider using theme text styles from app_theme.dart
    final currencyFormatter = NumberFormat.currency(
      locale: 'fr_FR', // Adjust locale as needed
      symbol: 'FCFA', // Currency symbol
      decimalDigits: 0, // No decimal digits as per image
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currencyFormatter.format(price),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.star, color: Colors.amber, size: 18)),
                SizedBox(width: 3),
                Text(
                  '$rating',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 1),
                TextButton(
                    onPressed: () {
                      showReviewsAll(context, [
                        ReviewItem(
                          rating: 5,
                          author: 'Shipon',
                          date: '10 Mar 2024',
                          comment:
                              'Super expérience de magasinage ! J\'utilise LNFOOT depuis un certain temps, maintenant et je suis impressionné par la large gamme de produits disponibles.',
                          imageUrls: [
                            'images/product1.png',
                            'images/product2.png',
                            'images/product3.png',
                          ],
                        ),
                        ReviewItem(
                          rating: 5,
                          author: 'Vessel',
                          date: '10 Mar 2024',
                          comment:
                              'Des achats incroyables ! J\'utilise LNFOOT depuis un certain temps et je suis impressionné par la sélection diversifiée de produits disponibles.',
                        ),
                      ]);
                    },
                    child: Text(
                      '($reviewCount Review)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
