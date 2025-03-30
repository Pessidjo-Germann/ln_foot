import 'package:flutter/material.dart';
import 'package:ln_foot/screen/product_details_screen.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/model/product.dart';
import 'package:ln_foot/widgets/common/product_card.dart';
import 'package:ln_foot/widgets/search/empty_search_result.dart';

import '../widgets/common/product_loading_grid.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;
  const SearchResultsScreen({super.key, required this.searchQuery});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool _isLoading = true;
  List<Product> _searchResults = [];

  // Définir le ratio d'aspect pour les éléments de la grille
  static const double _gridChildAspectRatio = 0.58;

  @override
  void initState() {
    super.initState();
    _fetchSearchResults();
  }

  Future<void> _fetchSearchResults() async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _searchResults = _getSampleProducts()
          .where((product) =>
              product.name
                  .toLowerCase()
                  .contains(widget.searchQuery.toLowerCase()) ||
              product.category
                  .toLowerCase()
                  .contains(widget.searchQuery.toLowerCase()))
          .toList();

      _isLoading = false;
    });
  }

  List<Product> _getSampleProducts() {
    return const [
      Product(
        imageUrl: 'images/Rectangle 857.png',
        name: 'Godass Nike Extra Long Name To Test Wrapping Behavior',
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
        name: 'Short Adidas Performance Ultra Light Weight',
        category: 'Vetement',
        price: 7500,
        rating: 4.5,
        reviewCount: 80,
      ),
    ];
  }

  void _toggleFavorite(int index) {
    setState(() {
      final product = _searchResults[index];
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
      _searchResults[index] = updatedProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.searchQuery, showBackButton: true),
      body: SafeArea(
        child: _isLoading
            ? ProductLoadingGrid()
            : _searchResults.isEmpty
                ? EmptySearchResults(searchQuery: widget.searchQuery)
                : _buildResultsView(),
      ),
    );
  }

  Widget _buildResultsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${_searchResults.length} résultats trouvés',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              itemCount: _searchResults.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: _gridChildAspectRatio,
              ),
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)));
                  },
                  onFavoriteTap: () => _toggleFavorite(index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
