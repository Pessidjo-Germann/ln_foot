import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductImageSection extends StatefulWidget {
  final String imageUrl;
  final bool initialIsFavorite;
  final VoidCallback? onFavoriteToggle;

  const ProductImageSection({
    super.key,
    required this.imageUrl,
    this.initialIsFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  _ProductImageSectionState createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onFavoriteToggle?.call(); // Call the callback if provided
  }

  @override
  Widget build(BuildContext context) {
    // Determine image dimensions or aspect ratio if needed
    // For now, let it expand within constraints
    return Container(
      // Add background color or decoration if needed, e.g., light grey
      color: Colors.grey[200],
      padding: EdgeInsets.all(16.0), // Padding around the image
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              widget.imageUrl,
              fit: BoxFit.contain, // Adjust fit as needed
              height: 250, // Set a reasonable height, adjust as needed
              placeholderBuilder: (BuildContext context) => Container(
                height: 250, // Match height
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.8), // Semi-transparent background
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color:
                      isFavorite ? Colors.red : Colors.grey, // Use theme colors
                ),
                onPressed: _toggleFavorite,
                tooltip: 'Ajouter aux favoris',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
