import 'package:flutter/material.dart';
import 'package:ln_foot/model/product.dart';
import 'package:ln_foot/widgets/common/product_card.dart'; // Import ProductCard and Product model
import 'package:shimmer/shimmer.dart'; // Import shimmer

// Placeholder list of products - replace with actual data fetching logic
const List<Product> _sampleProducts = [
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Godass Nike',
    category: 'Chaussure',
    price: 25000,
    oldPrice: 30000,
    rating: 4.8,
    reviewCount: 120,
    isFavorite: false,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Maillot',
    category: 'Maillot',
    price: 10000,
    oldPrice: 15000,
    rating: 4.8,
    reviewCount: 120,
    isFavorite: true,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Ballon Pro',
    category: 'Ballon',
    price: 8000,
    rating: 4.7,
    reviewCount: 95,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Short Adidas',
    category: 'Vetement',
    price: 7500,
    rating: 4.5,
    reviewCount: 80,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Short Adidas',
    category: 'Vetement',
    price: 7500,
    rating: 4.5,
    reviewCount: 80,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Short Adidas',
    category: 'Vetement',
    price: 7500,
    rating: 4.5,
    reviewCount: 80,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Short Adidas',
    category: 'Vetement',
    price: 7500,
    rating: 4.5,
    reviewCount: 80,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Short Adidas',
    category: 'Vetement',
    price: 7500,
    rating: 4.5,
    reviewCount: 80,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Short Adidas',
    category: 'Vetement',
    price: 7500,
    rating: 4.5,
    reviewCount: 80,
  ),
];

class SpecialOffersSection extends StatefulWidget {
  const SpecialOffersSection({super.key});

  @override
  State<SpecialOffersSection> createState() => _SpecialOffersSectionState();
}

class _SpecialOffersSectionState extends State<SpecialOffersSection> {
  bool _isLoading = true;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, fetch data from an API here
    setState(() {
      _products = _sampleProducts; // Use sample data for now
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Offres spéciales', // Special Offers
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),

          // Conditional GridView (Loading or Data)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _isLoading ? _buildLoadingGrid() : _buildProductGrid(),
          ),
          // Add some bottom padding if needed
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Builds the grid when data is loaded
  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: 0.75, // Increased aspect ratio
      ),
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductCard(
          product: product,
          onTap: () {
            print('Product ${product.name} tapped');
          },
          onFavoriteTap: () {
            print('Favorite toggled for ${product.name}');
            setState(() {
              // Create a new product with toggled favorite status
              final updatedProduct = Product(
                imageUrl: product.imageUrl,
                name: product.name,
                category: product.category,
                price: product.price,
                oldPrice: product.oldPrice,
                rating: product.rating,
                reviewCount: product.reviewCount,
                isFavorite: !product.isFavorite,
              );

              // Update the product in the list
              _products[index] = updatedProduct;
            });
          },
        );
      },
    );
  }

  // Builds the shimmer loading grid
  Widget _buildLoadingGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4, // Show 4 shimmer placeholders
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75, // Should match the product grid
        ),
        itemBuilder: (context, index) {
          return _buildShimmerPlaceholder();
        },
      ),
    );
  }

  // Builds a single shimmer placeholder card
  Widget _buildShimmerPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background for shimmer effect
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Container(
            height: 120, // Adjust height to match ProductCard image
            decoration: BoxDecoration(
              color: Colors.grey, // Placeholder color
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12.0)),
            ),
          ),
          const SizedBox(height: 8),
          // Text Placeholders
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity, height: 14.0, color: Colors.grey),
                const SizedBox(height: 4),
                Container(
                    width: double.infinity, height: 12.0, color: Colors.grey),
                const SizedBox(height: 8),
                Container(width: 80, height: 10.0, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
