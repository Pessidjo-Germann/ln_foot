import 'package:flutter/material.dart';

class EmptySearchResults extends StatelessWidget {
  final String searchQuery;
  final String imagePath;
  final String titleText;
  final String subtitleText;

  const EmptySearchResults({
    super.key,
    required this.searchQuery,
    this.imagePath = 'images/Search-rafiki 1.png',
    this.titleText = 'Aucun résultat pour',
    this.subtitleText = 'Essayez avec d\'autres mots-clés',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 16),
          Text(
            '$titleText "$searchQuery"',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitleText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}