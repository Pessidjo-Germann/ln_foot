import 'package:flutter/material.dart';
import 'popular_search_item.dart'; // Import the item widget

class PopularSearchesSection extends StatelessWidget {
  final List<String> popularSearches;
  final VoidCallback onClearAll;
  final Function(int) onRemoveItem; // Callback to remove a specific item by index

  const PopularSearchesSection({
    super.key,
    required this.popularSearches,
    required this.onClearAll,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    if (popularSearches.isEmpty) {
      // Optionally return a placeholder or an empty container
      // return const Center(child: Text("No popular searches"));
      return const SizedBox.shrink(); // Or return an empty widget
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: Title and Clear All button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recherches populaires",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Use theme color later
              ),
            ),
            TextButton(
              onPressed: onClearAll,
              child: Text(
                "Clear All",
                style: TextStyle(color: Colors.grey[600]), // Use theme color later
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30), // Adjust size if needed
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),

        // List of popular searches
        Expanded(
          child: ListView.separated(
            itemCount: popularSearches.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey), // Use theme color later
            itemBuilder: (context, index) {
              final itemText = popularSearches[index];
              return PopularSearchItem(
                text: itemText,
                onRemove: () => onRemoveItem(index),
                onTap: () {
                  // Optional: Handle tap on popular search (e.g., fill search bar)
                  print("Tapped popular search: $itemText");
                  // Potentially call a callback to update the search bar in the parent screen
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
