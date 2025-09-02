import 'package:flutter/material.dart';

class PopularSearchItem extends StatelessWidget {
  final String text;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const PopularSearchItem({
    super.key,
    required this.text,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.black), // Use theme text style later
        overflow: TextOverflow.ellipsis, // Prevent long text overflow
      ),
      trailing: IconButton(
        icon: Icon(Icons.close, color: Colors.grey[600]), // Use theme color later
        onPressed: onRemove,
        tooltip: 'Remove search',
        // Ensure sufficient tap target size
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        padding: EdgeInsets.zero,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0), // Adjust padding as needed
      dense: true,
      onTap: onTap,
    );
  }
}
