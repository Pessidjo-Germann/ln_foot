import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> availableColors;
  final Color? selectedColor;
  final ValueChanged<Color?> onColorSelected;
  final String initialColorName; 

  const ColorSelector({
    super.key,
    required this.availableColors,
    required this.selectedColor,
    required this.onColorSelected,
    this.initialColorName = '', // Default empty
  }) ;

  Color _getCheckmarkColor(Color backgroundColor) {
    return ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    // Consider using theme styles from app_theme.dart
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selectionner couleur: ${selectedColor != null ? '' : initialColorName}', // Needs logic to map Color to Name
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87, // Use theme color
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12.0, // Horizontal space between circles
          runSpacing: 8.0, // Vertical space between lines
          children: availableColors.map((color) {
            final bool isSelected = selectedColor == color;
            return GestureDetector(
              onTap: () {
                onColorSelected(isSelected ? null : color);
              },
              child: Container(
                width: 32, // Adjust size as needed
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
                    width: isSelected ? 2.5 : 1.0,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ] : null,
                ),
                child: isSelected
                    ? Center(
                        child: Icon(
                          Icons.check,
                          color: _getCheckmarkColor(color),
                          size: 18,
                        ),
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
