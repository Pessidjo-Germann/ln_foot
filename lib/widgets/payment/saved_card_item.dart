import 'package:flutter/material.dart';

// TODO: Potentially create a CardModel instead of using Map<String, dynamic>

class SavedCardItem extends StatelessWidget {
  final String id;
  final String brand;
  final String last4;
  final bool isDefault;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const SavedCardItem({
    super.key,
    required this.id,
    required this.brand,
    required this.last4,
    required this.isDefault,
    required this.selectedValue,
    required this.onChanged,
  });

  // Helper to get appropriate card icon (replace with actual assets if available)
  Widget _getCardIcon() {
    // TODO: Replace with Image.asset if you have specific icons for Visa/Mastercard
    IconData iconData;
    Color iconColor = Colors.black; // Default color
    switch (brand.toLowerCase()) {
      case 'visa':
        // Placeholder - Use a specific Visa icon if available
        iconData = Icons.credit_card; // Example: FontAwesomeIcons.ccVisa
        iconColor = Colors.blue[800]!;
        break;
      case 'mastercard':
         // Placeholder - Use a specific Mastercard icon if available
        iconData = Icons.credit_card; // Example: FontAwesomeIcons.ccMastercard
         iconColor = Colors.orange[800]!;
        break;
      default:
        iconData = Icons.credit_card;
    }
    // Using a generic icon for now, ideally replace with brand-specific assets
    // return Image.asset('assets/icons/${brand.toLowerCase()}.png', width: 30);
     return Icon(iconData, size: 30, color: iconColor);
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = id == selectedValue;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onChanged(id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          // Use theme colors for consistency
          color: isSelected ? colorScheme.primaryContainer.withOpacity(0.3) : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected ? [
             BoxShadow(
               color: colorScheme.primary.withOpacity(0.1),
               blurRadius: 4,
               offset: const Offset(0, 2),
             )
          ] : [],
        ),
        child: Row(
          children: [
            _getCardIcon(),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$brand **** **** **** $last4',
                    style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                    ),
                  ),
                  if (isDefault) ...[
                    const SizedBox(height: 4.0),
                    Chip(
                      label: const Text('Défaut'),
                      padding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      visualDensity: VisualDensity.compact,
                      labelStyle: textTheme.labelSmall?.copyWith(color: colorScheme.primary),
                      backgroundColor: colorScheme.primary.withOpacity(0.1),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ]
                ],
              ),
            ),
            Radio<String>(
              value: id,
              groupValue: selectedValue,
              onChanged: onChanged,
              activeColor: colorScheme.primary,
              // Ensure visual consistency
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
