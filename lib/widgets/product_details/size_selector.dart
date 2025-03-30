import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final List<String> availableSizes;
  final String? selectedSize;
  final ValueChanged<String?> onSizeSelected;

  const SizeSelector({
    Key? key,
    required this.availableSizes,
    required this.selectedSize,
    required this.onSizeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Consider using theme styles from app_theme.dart
    final Color selectedColor = Theme.of(context).primaryColor; // Example: Use primary color for selected
    final Color unselectedColor = Colors.grey[200]!; // Example: Light grey for unselected background
    final Color selectedTextColor = Colors.white;
    final Color unselectedTextColor = Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selectionner la taille', // Consider localization
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87, // Use theme color
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12.0, // Horizontal space between chips
          runSpacing: 8.0, // Vertical space between lines of chips
          children: availableSizes.map((size) {
            final bool isSelected = selectedSize == size;
            return ChoiceChip(
              label: Text(size),
              selected: isSelected,
              onSelected: (selected) {
                onSizeSelected(selected ? size : null);
              },
              selectedColor: selectedColor,
              backgroundColor: unselectedColor,
              labelStyle: TextStyle(
                color: isSelected ? selectedTextColor : unselectedTextColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: isSelected ? selectedColor : Colors.grey[400]!, // Border color
                  width: 1,
                ),
              ),
              showCheckmark: false, // Don't show checkmark, selection is indicated by color
            );
          }).toList(),
        ),
      ],
    );
  }
}
