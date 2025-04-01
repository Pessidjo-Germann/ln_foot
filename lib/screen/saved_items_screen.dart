import 'package:flutter/material.dart';
import 'package:ln_foot/screen/product_details_screen.dart';
import 'package:ln_foot/widgets/saved_items/shimmer_product_card.dart';
import '../model/product.dart'; // Assuming Product model exists
import '../widgets/common/product_card.dart'; // Reusable product card
import '../widgets/custom_app_bar.dart'; // Reusable app bar
import '../widgets/saved_items/empty_saved_items_view.dart'; // Empty state view

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {

    bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // TODO: Replace placeholder data with actual saved items logic
  final List<Product> _savedItems = [
    const Product(
      name: 'Ballon de foot Nike',
      category: 'Équipement', // Placeholder category
      imageUrl:
          'images/product1.png', // Placeholder - use actual image path/URL
      price: 10000,
      oldPrice: 15000,
      rating: 4.8,
      reviewCount: 80,
      isFavorite: true,
    ),
    const Product(
      name: 'Maillot',
      category: 'Vêtements', // Placeholder category
      imageUrl: 'images/product2.png', // Placeholder
      price: 10000,
      oldPrice: 15000,
      rating: 4.8,
      reviewCount: 80,
      isFavorite: true,
    ),
    const Product(
      name: 'Godasse Nike',
      category: 'Chaussures', // Placeholder category
      imageUrl: 'images/product3.png', // Placeholder
      price: 25000,
      oldPrice: 30000,
      rating: 4.8,
      reviewCount: 120,
      isFavorite: true,
    ),
    const Product(
      name: 'Maillot Cameroun',
      category: 'Vêtements', // Placeholder category
      imageUrl:
          'images/maillot_asset.svg', // Placeholder - Assuming SVG, adjust ProductCard if needed
      price: 15000,
      oldPrice: 20000,
      rating: 4.8,
      reviewCount: 120,
      isFavorite: true,
    ),
    // Add more placeholder items if needed
  ];

  // In a real app, you'd fetch this data, e.g., in initState

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isEmpty = _savedItems.isEmpty;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Éléments enregistrés',
        showBackButton: true,
        actions: [
          // Notification icon as seen in the design
          IconButton(
            icon: const Icon(Icons
                .notifications_none_outlined), // Or use your custom icon if available
            onPressed: () {
              // TODO: Navigate to notifications screen
              print('Notification icon pressed');
            },
          ),
        ],
      ),
      body:
      _isLoading?ShimmerProductCard(): 
           isEmpty
          ? const EmptySavedItemsView()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    '${_savedItems.length} Items',
                    style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio:
                          0.6, // Adjust aspect ratio as needed for ProductCard layout
                    ),
                    itemCount: _savedItems.length,
                    itemBuilder: (context, index) {
                      final product = _savedItems[index];
                      return ProductCard(
                        product: product,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsScreen(product: product))),
                        onFavoriteTap: () {
                          setState(() {
                            _savedItems.removeAt(index);
                          });
                          print('Toggled favorite for ${product.name}');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
