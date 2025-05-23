import 'package:flutter/material.dart';

class ProductDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Consider using theme colors/styles from app_theme.dart
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black), // Use theme color
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Product Details',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Use theme text style
      ),
      backgroundColor: Colors.white, // Use theme background color
      elevation: 0, // No shadow as per the image
      centerTitle: true, // Center title as per the image
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
