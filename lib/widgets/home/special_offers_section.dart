import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/screen/product_details_screen.dart';
import 'package:ln_foot/widgets/common/product_card.dart';
import 'package:lnFoot_api/api.dart';
import 'package:shimmer/shimmer.dart';

const double _gridChildAspectRatio = 0.62;

class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Offres spéciales',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return switch (state) {
                  ProductInitial() => _buildLoadingGrid(),
                  ProductLoading() => _buildLoadingGrid(),
                  ProductsLoaded(products: final products) => products.isEmpty
                      ? const Center(child: Text('Aucun produit trouvé.'))
                      : _buildProductGrid(context, products),
                    ProductError(message: final message) => () {
                    if (message.contains('401')) {
                      context.read<AuthBloc>().add(LogoutRequested());
                    }
                    return _buildLoadingGrid();
                    }(),
                    _ => _buildLoadingGrid(),
                };
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
        product: product,
        onTap: () {
          if (product.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Impossible d\'afficher les détails du produit (ID manquant).')),
            );
          }
        },
      );
    },
  );
}

Widget _buildLoadingGrid() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
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
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 14.0,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity * 0.7,
                height: 14.0,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                width: 60,
                height: 10.0,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: 80,
                height: 12.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
