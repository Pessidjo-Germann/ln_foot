import 'package:flutter/material.dart';
import 'search_suggestion_item.dart'; // Import the item widget

class SearchSuggestionsSection extends StatelessWidget {
  final List<String> suggestions;
  final String searchQuery; // Can be used for highlighting later
  final Function(String)
      onSuggestionTap; // Callback when a suggestion is tapped
  final Function(int)
      onRemoveSuggestion; // Callback to remove a suggestion (by index)

  const SearchSuggestionsSection({
    super.key,
    required this.suggestions,
    required this.searchQuery,
    required this.onSuggestionTap,
    required this.onRemoveSuggestion,
  });

  @override
  Widget build(BuildContext context) {
    // Filtering is currently handled in the parent screen,
    // but could be moved here if needed.
    final filteredSuggestions =
        suggestions; // Assuming parent passes filtered list

    if (filteredSuggestions.isEmpty && searchQuery.isNotEmpty) {
      return Center(
          child: Column(
        children: [
          Image.asset("images/Search-rafiki 1.png"),
          const SizedBox(height: 8),
          Text("Aucun resultat trouve \"$searchQuery\""),
        ],
      ));
    } else if (filteredSuggestions.isEmpty) {
      return const SizedBox.shrink(); // Nothing to show if empty
    }

    return ListView.separated(
      itemCount: filteredSuggestions.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: Colors.grey), // Use theme color later
      itemBuilder: (context, index) {
        final suggestion = filteredSuggestions[index];
        return SearchSuggestionItem(
          suggestion: suggestion,
          searchQuery: searchQuery, // Pass query for potential highlighting
          onRemove: () => onRemoveSuggestion(index),
          onTap: () => onSuggestionTap(suggestion),
        );
      },
    );
  }
}
