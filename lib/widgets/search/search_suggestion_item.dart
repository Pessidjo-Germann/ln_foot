import 'package:flutter/material.dart';

class SearchSuggestionItem extends StatelessWidget {
  final String suggestion;
  final String searchQuery; // For potential highlighting
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const SearchSuggestionItem({
    super.key,
    required this.suggestion,
    required this.searchQuery,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement highlighting logic for searchQuery within suggestion
    // For now, just display the plain text
    return ListTile(
      title: Text(
        suggestion,
        style: const TextStyle(color: Colors.black), // Use theme text style later
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(Icons.close, color: Colors.grey[600]), // Use theme color later
        onPressed: onRemove,
        tooltip: 'Remove suggestion',
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        padding: EdgeInsets.zero,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0), // Adjust padding
      dense: true,
      onTap: onTap,
    );
  }
}
