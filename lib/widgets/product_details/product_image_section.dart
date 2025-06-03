import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';
import 'package:ln_foot/model/saved_product_dto.dart';
import 'package:lnFoot_api/api.dart';

class ProductImageSection extends StatelessWidget {
  final String imageUrl;
  final ProductDto product;
  final String? mainProductId;

  final VoidCallback? onFavoriteToggle;

  const ProductImageSection({
    super.key,
    required this.imageUrl,
    required this.product,
    this.onFavoriteToggle,
    this.mainProductId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: BlocBuilder<SavedItemsBloc, SavedItemsState>(
                builder: (context, state) {
                  bool isSaved = false;

                  if (state is SavedItemsLoaded) {
                    isSaved = state.items
                        .any((item) => item.product.id == mainProductId);
                  }

                  return IconButton(
                    icon: Icon(
                      isSaved ? Icons.favorite : Icons.favorite_border,
                      color: isSaved ? const Color(0xFFF16A26) : Colors.grey,
                    ),
                    onPressed: () {
                      if (onFavoriteToggle != null) {
                        onFavoriteToggle!();
                      } else {
                        // Fallback si pas de callback fourni
                        final bloc = context.read<SavedItemsBloc>();
                        if (state is SavedItemsLoaded) {
                          if (isSaved) {
                            bloc.add(RemoveSavedItem(product.id!));
                          } else {
                            final savedProduct = SavedProductDto(
                              product: product,
                              selectedVariantId: null,
                              variantImageUrl: null,
                            );
                            bloc.add(AddSavedItem(savedProduct));
                          }
                        }
                      }
                    },
                    tooltip:
                        isSaved ? 'Retirer des favoris' : 'Ajouter aux favoris',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
