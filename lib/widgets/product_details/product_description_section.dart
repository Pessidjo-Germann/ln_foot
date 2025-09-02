import 'package:flutter/material.dart';

class ProductDescriptionSection extends StatelessWidget {
  final String description;

  const ProductDescriptionSection({
    super.key,
    required this.description,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detail du produit', 
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            color: Colors.black87, 
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14, 
            color: Colors.grey[700], 
            height: 1.5, 
          ),
        ),
      ],
    );
  }
}
