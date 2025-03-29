import 'package:flutter/material.dart';
import 'package:ln_foot/model/product.dart';
import 'package:ln_foot/widgets/common/product_card.dart'; // Import ProductCard and Product model
import 'package:shimmer/shimmer.dart'; // Import shimmer

// Placeholder list of products - replace with actual data fetching logic
const List<Product> _sampleProducts = [
  // ... (keep your sample products)
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name:
        'Godass Nike Extra Long Name To Test Wrapping Behavior', // Example longer name
    category: 'Chaussure',
    price: 25000,
    oldPrice: 30000,
    rating: 4.8,
    reviewCount: 1270,
    isFavorite: false,
  ),
  Product(
    imageUrl: 'images/Rectangle 857.png',
    name: 'Maillot',
    category: 'Maillot',
    price: 10000,
    oldPrice: 15000,
    rating: 4.8,
    reviewCount: 1520,
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
    name: 'Short Adidas Performance Ultra Light Weight', // Example longer name
    category: 'Vetement',
    price: 7500,
    rating: 4.5,
    reviewCount: 80,
  ),
  // Add more sample products if needed
];

class SpecialOffersSection extends StatefulWidget {
  const SpecialOffersSection({super.key});

  @override
  State<SpecialOffersSection> createState() => _SpecialOffersSectionState();
}

class _SpecialOffersSectionState extends State<SpecialOffersSection> {
  bool _isLoading = true;
  List<Product> _products = [];

  // --- Define Aspect Ratio Consistently ---
  // Adjust this value based on testing to eliminate overflow
  // Smaller value = more height relative to width
  static const double _gridChildAspectRatio = 0.58; // START HERE and adjust

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, fetch data from an API here
    // Make sure the product list has enough items to test scrolling if needed
    setState(() {
      _products = List.generate(
          8,
          (index) => _sampleProducts[
              index % _sampleProducts.length]); // Ensure enough items
      _isLoading = false;
    });
  }

  // Helper to update favorite status immutably
  void _toggleFavorite(int index) {
    setState(() {
      final product = _products[index];
      // Create a new product instance with toggled favorite status
      final updatedProduct = Product(
        imageUrl: product.imageUrl,
        name: product.name,
        category: product.category,
        price: product.price,
        oldPrice: product.oldPrice,
        rating: product.rating,
        reviewCount: product.reviewCount,
        isFavorite: !product.isFavorite, // Toggle the value
        // Make sure to include ALL fields from your Product model here
        // id: product.id, // if you have an ID, etc.
      );
      // Replace the old product with the updated one in the list
      _products[index] = updatedProduct;
    });
    print('Favorite toggled for ${_products[index].name}');
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
          // const SizedBox(height: 16), // Usually not needed if Grid is last
        ],
      ),
    );
  }

  // Builds the grid when data is loaded
  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap:
          true, // Important: Prevents GridView from taking infinite height
      physics:
          const NeverScrollableScrollPhysics(), // Grid doesn't scroll itself
      itemCount: _products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12, // Increased spacing slightly for better visuals
        mainAxisSpacing: 12, // Increased spacing slightly
        childAspectRatio: _gridChildAspectRatio, // USE THE ADJUSTED VALUE
      ),
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductCard(
          product: product,
          onTap: () {
            print('Product ${product.name} tapped');
            // Navigate to product details screen, etc.
          },
          onFavoriteTap: () => _toggleFavorite(index), // Use the helper method
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
        itemCount: 6, // Show a few shimmer placeholders (e.g., 4 or 6)
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12, // MATCH product grid
          mainAxisSpacing: 12, // MATCH product grid (FIXED from 106)
          childAspectRatio: _gridChildAspectRatio, // MATCH product grid
        ),
        itemBuilder: (context, index) {
          return _buildShimmerPlaceholder();
        },
      ),
    );
  }

  // Builds a single shimmer placeholder card
  Widget _buildShimmerPlaceholder() {
    // Get screen width to estimate card width for better placeholder sizing
    // final screenWidth = MediaQuery.of(context).size.width;
    // final cardWidth = (screenWidth - (16.0 * 2) - 12.0) / 2; // padding - spacing / crossAxisCount
    // final imageHeight = cardWidth / 1.0; // Since image aspect ratio is 1.0

    return Card(
      // Use Card for consistent shape/elevation during loading
      elevation: 1.5,
      shadowColor: Colors.grey.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder - Use AspectRatio to mimic the real card
          AspectRatio(
            aspectRatio: 1.0, // Match ProductCard's image AspectRatio
            child: Container(
              color: Colors.white, // Shimmer works best over solid colors
            ),
          ),
          // Text Placeholders
          Flexible(
            // Use Flexible here too
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  12.0, 8.0, 12.0, 10.0), // Match ProductCard padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 60, height: 12.0, color: Colors.white), // Category
                  const SizedBox(height: 4), // Adjusted spacing slightly
                  Container(
                      width: double.infinity,
                      height: 16.0,
                      color: Colors.white), // Name line 1
                  const SizedBox(height: 4),
                  Container(
                      width: double.infinity * 0.7,
                      height: 16.0,
                      color: Colors.white), // Name line 2 (partial)
                  const SizedBox(height: 8), // Adjusted spacing
                  Container(
                      width: 80, height: 14.0, color: Colors.white), // Price
                  const SizedBox(height: 10), // Adjusted spacing
                  Container(
                      width: 100,
                      height: 12.0,
                      color: Colors.white), // Rating/Reviews
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
