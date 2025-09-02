import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isSearching;
  final VoidCallback onClear;
  final VoidCallback? onCameraTap; // Optional callback for camera icon

  const SearchInputField({
    super.key,
    required this.controller,
    required this.isSearching,
    required this.onClear,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Use theme color later
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSearching ? Colors.orange : Colors.transparent, // Use theme color later
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Trouvez vos articles préférés",
          hintStyle: TextStyle(color: Colors.grey[600]), // Use theme text style later
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey[600]), // Use theme color later
          suffixIcon: isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel, color: Colors.grey[600]), // Use theme color later
                  onPressed: onClear,
                  tooltip: 'Clear search',
                )
              : IconButton( // Make camera icon tappable
                  icon: Icon(Icons.camera_alt_outlined, color: Colors.grey[600]), // Use theme color later
                  onPressed: onCameraTap,
                  tooltip: 'Search by image', // Add tooltip
                ),
        ),
        style: const TextStyle(color: Colors.black), // Use theme text style later
        cursorColor: Colors.orange, // Use theme color later
      ),
    );
  }
}
