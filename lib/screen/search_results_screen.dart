import 'package:flutter/material.dart';
import 'package:lnFoot_api/api.dart';

import 'package:ln_foot/screen/product_details_screen.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
// Garder Product pour l'instant
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
  List<ProductDto> _searchResults = [];
  // Garder la logique de recherche locale pour cet exemple

  // Définir le ratio d'aspect pour les éléments de la grille
  static const double _gridChildAspectRatio = 0.58;

  @override
  void initState() {
    super.initState();
    _fetchSearchResults();
    // Pas besoin de charger SavedItems ici car il est chargé dans main.dart
  }

  Future<void> _fetchSearchResults() async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(seconds: 1));

    // Utiliser les données d'exemple pour la recherche locale
    final sampleProducts = _getSampleProducts();

    setState(() {
      _searchResults = sampleProducts
          .where((product) => product.name!
              .toLowerCase()
              .contains(widget.searchQuery.toLowerCase()))
          .toList();

      _isLoading = false;
    });
  }

  // Données d'exemple (gardées pour la démo de recherche locale)
  List<ProductDto> _getSampleProducts() {
    // Assurez-vous que les produits ont des IDs uniques si possible
    return [
      ProductDto(
        id: 'sample1', // Ajouter un ID
        imageUrl: 'images/Rectangle 857.png',
        name: 'Godass Nike Extra Long Name To Test Wrapping Behavior',
        // category: 'Chaussure',
        price: 25000,
        // oldPrice: 30000,
        // rating: 4.8,
        // reviewCount: 1270,
        // isFavorite: false, // Sera déterminé par le Bloc
      ),
      ProductDto(
        id: 'sample2', // Ajouter un ID
        imageUrl: 'images/Rectangle 857.png',
        name: 'Maillot',
        // category: 'Maillot',
        price: 10000,
        //oldPrice: 15000,
        //rating: 4.8,
        // reviewCount: 1520,
        // isFavorite: false, // Sera déterminé par le Bloc
      ),
      ProductDto(
        id: 'sample3', // Ajouter un ID
        imageUrl: 'images/Rectangle 857.png',
        name: 'Ballon Pro',
        //  category: 'Ballon',
        price: 8000,
        // rating: 4.7,
        // reviewCount: 95,
        // isFavorite: false,
      ),
      ProductDto(
        id: 'sample4', // Ajouter un ID
        imageUrl: 'images/Rectangle 857.png',
        name: 'Short Adidas Performance Ultra Light Weight',
        // category: 'Vetement',
        price: 7500,
        // rating: 4.5,
        // reviewCount: 80,
        // isFavorite: false,
      ),
    ];
  }

  // Supprimer _toggleFavorite car géré par le Bloc
  /*
  void _toggleFavorite(int index) {
    setState(() {
      final product = _searchResults[index];
      final updatedProduct = Product(
        // ... (copie avec isFavorite inversé)
      );
      _searchResults[index] = updatedProduct;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.searchQuery,
        showBackButton: true,
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: _isLoading
            ? ProductLoadingGrid() // Afficher le chargement initial
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
