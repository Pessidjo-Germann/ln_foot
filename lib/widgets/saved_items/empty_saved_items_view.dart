import 'package:flutter/material.dart';

class EmptySavedItemsView extends StatelessWidget {
  const EmptySavedItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border, // Using standard favorite border icon
              size: 80,
              color: Colors.grey[400], // Adjusting color for better visibility,
            ),
            const SizedBox(height: 24),
            Text(
              'Aucun éléments enregistré !',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Vous n\'avez aucun élément enregistré. Accédez à l\'accueil et ajoutez-en.',
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
