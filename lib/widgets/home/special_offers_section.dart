import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart'; // Import ProductBloc
import 'package:ln_foot/screen/product_details_screen.dart';
import 'package:ln_foot/widgets/common/product_card.dart';
import 'package:lnFoot_api/api.dart';
import 'package:shimmer/shimmer.dart';

const double _gridChildAspectRatio = 0.65; // Adjusted aspect ratio

class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key});

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

          // Use BlocBuilder to react to ProductBloc states
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading || state is ProductInitial) {
                  return _buildLoadingGrid(); // Show shimmer
                } else if (state is ProductsLoaded) {
                  if (state.products.isEmpty) {
                    return const Center(
                        child:
                            Text('Aucun produit trouvé.')); // Handle empty list
                  }
                  return _buildProductGrid(
                      context, state.products); // Show products
                } else if (state is ProductError) {
                  return Center(
                      child: Text('Erreur: ${state.message}')); // Show error
                } else {
                  return const Center(child: Text('État inconnu.')); // Fallback
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProductGrid(BuildContext context, List<ProductDto> products) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: _gridChildAspectRatio,
    ),
    itemBuilder: (context, index) {
      final product = products[index];
      return ProductCard(
        product: product, // Pass ProductDto
        onTap: () {
          if (product.id != null) {
            // Navigate passing only the product ID
            Navigator.push(
              context,
              MaterialPageRoute(
                // Assuming ProductDetailsScreen will be updated to take productId
                builder: (context) => ProductDetailsScreen(product: product),
              ),
            );
          } else {
            // Handle case where ID is null (optional: show a snackbar)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Impossible d\'afficher les détails du produit (ID manquant).')),
            );
          }
        },
        // onFavoriteTap removed
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
      itemCount: 6, // Show shimmer placeholders
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: _gridChildAspectRatio,
      ),
      itemBuilder: (context, index) {
        return _buildShimmerPlaceholder();
      },
    ),
  );
}

// Builds a single shimmer placeholder card
Widget _buildShimmerPlaceholder() {
  return Card(
    elevation: 1.5,
    shadowColor: Colors.grey.withOpacity(0.15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Placeholder
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(color: Colors.white),
        ),
        // Text Placeholders
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.white), // Name line 1
                const SizedBox(height: 4),
                Container(
                    width: double.infinity * 0.7,
                    height: 16.0,
                    color: Colors.white), // Name line 2
                const SizedBox(height: 4),
                Container(
                    width: 60, height: 12.0, color: Colors.white), // Category
                const SizedBox(height: 8),
                Container(
                    width: 80, height: 14.0, color: Colors.white), // Price
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
