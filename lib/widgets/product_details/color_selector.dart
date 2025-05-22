import 'package:flutter/material.dart';
import 'package:lnFoot_api/api.dart'; // Import ProductVariantDto

class ColorSelector extends StatelessWidget {
  final List<ProductVariantDto> variants;
  final ProductVariantDto? selectedVariant;
  final Function(ProductVariantDto variant) onVariantSelected;

  const ColorSelector({
    super.key,
    required this.variants,
    required this.selectedVariant,
    required this.onVariantSelected,
  });

  Color _getColorFromCode(String? code) {
    if (code == null) return Colors.grey; // Default
    String lowerCode = code.toLowerCase();
    if (lowerCode.startsWith('#')) {
      // Ensure the hex code is valid (e.g., #RRGGBB or #AARRGGBB)
      if (lowerCode.length == 7) { // #RRGGBB
        return Color(int.parse(lowerCode.substring(1), radix: 16) + 0xFF000000);
      } else if (lowerCode.length == 9) { // #AARRGGBB
        return Color(int.parse(lowerCode.substring(1), radix: 16));
      }
    }
    switch (lowerCode) {
      case 'rouge':
      case 'red':
        return Colors.red;
      case 'noir':
      case 'black':
        return Colors.black;
      case 'bleu':
      case 'blue':
        return Colors.blue;
      case 'vert':
      case 'green':
        return Colors.green;
      case 'blanc':
      case 'white':
        return Colors.white;
      case 'rose':
      case 'pink':
        return Colors.pink;
      case 'violet':
      case 'purple':
        return Colors.purple;
      // Add more known color names
      default:
        return Colors.grey; // Fallback for unknown names or invalid hex
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Couleur', 
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold) ?? 
                 const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: variants.map((variant) {
            final color = _getColorFromCode(variant.colorCode);
            final bool isSelected = selectedVariant?.id == variant.id;

            return GestureDetector(
              onTap: () => onVariantSelected(variant),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                    )
                  ],
                ),
                child: isSelected && color.computeLuminance() > 0.5
                    ? Icon(Icons.check, color: Colors.black, size: 18)
                    : isSelected
                        ? Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
