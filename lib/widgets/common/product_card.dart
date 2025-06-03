import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lnFoot_api/api.dart';
import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductDto product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'fr_CM',
    symbol: '',
    decimalDigits: 0,
  );

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1.5,
        shadowColor: Colors.grey.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 380, // Fixed height for the card
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (product.imageUrl != null &&
                        product.imageUrl!.isNotEmpty)
                      Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Colors.grey.shade400,
                            size: 40,
                          ),
                        ),
                      )
                    else
                      Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey.shade400,
                          size: 40,
                        ),
                      ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8.0),
                        elevation: 1.0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            final bloc = context.read<SavedItemsBloc>();
                            final state = bloc.state;
                            if (state is SavedItemsLoaded) {
                              final isFavorite = state.items
                                  .any((item) => item.id == product.id);
                              if (isFavorite) {
                                bloc.add(RemoveSavedItem(product.id!));
                              } else {
                                bloc.add(AddSavedItem(product));
                              }
                            }
                            if (onFavoriteTap != null) onFavoriteTap!();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: BlocBuilder<SavedItemsBloc, SavedItemsState>(
                              builder: (context, state) {
                                bool isFavorite = false;
                                if (state is SavedItemsLoaded) {
                                  isFavorite = state.items
                                      .any((item) => item.id == product.id);
                                }
                                return Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite
                                      ? const Color(0xFFF16A26)
                                      : Colors.grey.shade700,
                                  size: 22,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if (product.categoryNames.isNotEmpty) ...[
                      //   Text(
                      //     product.categoryNames.join(', '),
                      //     style: theme.textTheme.bodySmall?.copyWith(
                      //       color: Colors.grey.shade600,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      //   const SizedBox(height: 4),
                      // ],
                      Flexible(
                        child: Text(
                          product.name ?? 'Unnamed Product',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_currencyFormatter.format(product.price)} FCFA',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '(0 avis)',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
