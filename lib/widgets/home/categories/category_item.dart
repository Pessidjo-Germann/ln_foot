
// Helper widget for individual category items
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected; // New field

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isSelected
        ? Theme.of(context).primaryColor.withOpacity(0.1)
        : Colors.grey.shade200;
    Color iconAndTextColor =
        isSelected ? Theme.of(context).primaryColor : Colors.grey.shade700;
    FontWeight labelFontWeight =
        isSelected ? FontWeight.bold : FontWeight.w500;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(iconAndTextColor, BlendMode.srcIn), // Apply color to SVG
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: iconAndTextColor,
              fontWeight: labelFontWeight,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
