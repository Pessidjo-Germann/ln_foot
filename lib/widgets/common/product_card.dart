import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ln_foot/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  // Create formatters once for efficiency if they don't change
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'fr_CM',
    symbol: '', // Symbole ajouté manuellement plus tard
    decimalDigits: 0,
  );
  static final NumberFormat _oldPriceNumberFormatter =
      NumberFormat.decimalPattern('fr_CM');

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // print(product.imageUrl);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1.5,
        shadowColor: Colors.grey.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip
            .antiAlias, // Important pour que l'image respecte les coins arrondis
        child: Column(
          // La Column principale organise l'image et les détails verticalement
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // La carte prend la hauteur minimale nécessaire
          children: [
            Stack(
              children: [
                AspectRatio(
                  // Définit le ratio largeur:hauteur. 1.0 = carré, 4/3 = paysage léger, etc.
                  // Choisir un ratio qui convient au design général de votre application.
                  aspectRatio:
                      1.0, // Image carrée par rapport à la largeur de la carte
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover, // Couvre l'espace de l'AspectRatio
                    semanticLabel: 'Image de ${product.name}',
                    // loadingBuilder: (context, child, loadingProgress) {
                    //   if (loadingProgress == null) return child;
                    //   return Container(
                    //     color: Colors.grey.shade200,
                    //     child: Center(
                    //       child: CircularProgressIndicator(
                    //         strokeWidth: 2,
                    //         value: loadingProgress.expectedTotalBytes != null
                    //             ? loadingProgress.cumulativeBytesLoaded /
                    //                 loadingProgress.expectedTotalBytes!
                    //             : null,
                    //       ),
                    //     ),
                    //   );
                    // },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey.shade400,
                          size: 40, // Taille de l'icône d'erreur
                        ),
                      ),
                    ),
                  ),
                ),
                // Bouton Favori
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8.0),
                    elevation: 1.0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: onFavoriteTap,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isFavorite
                              ? Colors.redAccent
                              : Colors.grey.shade700,
                          size: 22,
                          semanticLabel: product.isFavorite
                              ? 'Retirer des favoris'
                              : 'Ajouter aux favoris',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min, // La colonne interne prend aussi le min d'espace
                  children: [
                    // Catégorie
                    Text(
                      product.category,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),

                    // Nom du produit
                    Text(
                      product.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.2, // Ajustement de l'interligne si nécessaire
                      ),
                      maxLines: 1, // Permet au nom d'aller sur 2 lignes
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Section Prix
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${_currencyFormatter.format(product.price)} FCFA',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (product.oldPrice != null &&
                            product.oldPrice! > product.price) ...[
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '${_oldPriceNumberFormatter.format(product.oldPrice)} FCFA',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Section Notation
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '(${product.reviewCount} avis)',
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
    );
  }
}
