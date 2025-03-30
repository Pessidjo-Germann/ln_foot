import 'package:flutter/material.dart';
import '../widgets/home/search_bar_widget.dart'; // Import the existing SearchBarWidget
import '../widgets/search/popular_searches_section.dart';
import '../widgets/search/search_suggestions_section.dart';
import 'search_results_screen.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false; // To track if the user is typing

  // Dummy data for popular searches
  final List<String> _popularSearches = [
    "Jeans",
    "Maillot",
    "Choisible", // Assuming this is a typo in the image, keeping it for now
    "Godass",    // Assuming this is a typo/slang, keeping it for now
    "Ballon foot",
    "Ballon basket",
  ];

  // Dummy data for search suggestions
  final List<String> _searchSuggestions = [
    "Godasse adidas",
    "Godasse Nike",
    "Godasse Double crampon",
    "Godasse Triple crampon",
    "Godasse mercurole", // Assuming typo
    "Godasse Puma",
    "Godasse puma fast", // Assuming typo
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  void _removePopularSearch(int index) {
    setState(() {
      _popularSearches.removeAt(index);
    });
    // TODO: Add logic to persist this change if needed
  }

  void _clearAllPopularSearches() {
    setState(() {
      _popularSearches.clear();
    });
    // TODO: Add logic to persist this change if needed
  }

  void _removeSuggestion(int index) {
    // In a real app, this might remove from search history or just be ignored
    print("Remove suggestion action for: ${_searchSuggestions[index]} at index $index");
    // Example: If suggestions were stateful and could be removed
    // setState(() {
    //   _searchSuggestions.removeAt(index);
    // });
  }

  void _handleSuggestionTap(String suggestion) {
    // Fill search bar and move cursor to end
    _searchController.text = suggestion;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: _searchController.text.length),
    );
    // Optionally trigger search immediately or wait for user confirmation (e.g., pressing 'Go')
    print("Selected suggestion: $suggestion");
    // Hide keyboard maybe? FocusScope.of(context).unfocus();
  }

   void _handleCameraTap() {
    // Placeholder for image search functionality
    print("Camera icon tapped - initiate image search flow");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Image search not implemented yet.")),
    );
  }

  void _handleSearch() {
  if (_searchController.text.isNotEmpty) {
    FocusScope.of(context).unfocus();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(
          searchQuery: _searchController.text,
        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Using a standard AppBar for now
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Search', style: TextStyle(color: Colors.black)), // Placeholder title
        backgroundColor: Colors.white,
        elevation: 0, // Flat app bar
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Use the existing SearchBarWidget
            SearchBarWidget(
              controller: _searchController,
              isSearching: _isSearching,
              onClear: _clearSearch,
              onFilterTap: _handleCameraTap, 
              onSubmit: _handleSearch,
              // Use onFilterTap for the camera/scan action
              // onChanged: (value) => _onSearchChanged(), // Already handled by listener
              // We might need to adjust padding/margin if SearchBarWidget includes its own
            ),
            // const SizedBox(height: 24.0), // SearchBarWidget might have vertical padding, adjust if needed

            // 2. Conditional Content: Popular Searches or Suggestions
            Expanded(
              child: _isSearching
                  ? SearchSuggestionsSection(
                      suggestions: _searchSuggestions // Pass the full list for now
                          .where((s) => s.toLowerCase().contains(_searchController.text.toLowerCase()))
                          .toList(), // Filter suggestions based on input
                      searchQuery: _searchController.text,
                      onSuggestionTap: _handleSuggestionTap,
                      onRemoveSuggestion: _removeSuggestion,
                    )
                  : PopularSearchesSection(
                      popularSearches: _popularSearches,
                      onClearAll: _clearAllPopularSearches,
                      onRemoveItem: _removePopularSearch,
                    ),
            ),
          ],
        ),
      ),
    );
  }

}
