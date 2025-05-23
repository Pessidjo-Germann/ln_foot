import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';
import 'package:lnFoot_api/api.dart';

class ProductImageSection extends StatefulWidget {
  final String imageUrl;
  final ProductDto product;
  final bool initialIsFavorite;
  final VoidCallback? onFavoriteToggle;

  const ProductImageSection({
    super.key,
    required this.imageUrl,
    required this.product,
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
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover, // Adjust fit as needed
              height: 250, // Set a reasonable height, adjust as needed
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
              child: BlocBuilder<SavedItemsBloc, SavedItemsState>(
                builder: (context, state) {
                  bool isSaved = false;
                  if (state is SavedItemsLoaded) {
                    isSaved =
                        state.items.any((item) => item.id == widget.product.id);
                  }
                  return IconButton(
                    icon: Icon(
                      isSaved ? Icons.favorite : Icons.favorite_border,
                      color: isSaved ? const Color(0xFFF16A26) : Colors.grey,
                    ),
                    onPressed: () {
                      final bloc = context.read<SavedItemsBloc>();
                      if (state is SavedItemsLoaded) {
                        if (isSaved) {
                          bloc.add(RemoveSavedItem(widget.product.id!));
                        } else {
                          bloc.add(AddSavedItem(widget.product));
                        }
                      }
                      widget.onFavoriteToggle?.call();
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
