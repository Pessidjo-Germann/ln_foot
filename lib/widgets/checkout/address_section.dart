import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  final String addressType;
  final String fullAddress;
  final VoidCallback onChangePressed;

  const AddressSection({
    super.key,
    required this.addressType,
    required this.fullAddress,
    required this.onChangePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Adresse de livraison',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: onChangePressed,
              child: const Text('Change'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: Theme.of(context).primaryColor, // Use primary color for action text
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Address Details Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.grey.shade600,
              size: 20, // Slightly smaller icon
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressType, // e.g., "Maison"
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fullAddress, // e.g., "925 S Chugach St #APT 10, Alaska 99645"
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
