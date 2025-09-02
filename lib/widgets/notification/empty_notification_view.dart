
// Widget for the Empty State
import 'package:flutter/material.dart';

class EmptyNotificationsView extends StatelessWidget {
  const EmptyNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_outlined, // Or a custom illustration
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'Vous n\'avez pas encore reçu de notifications !',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Nous vous avertirons lorsque quelque chose d\'intéressant se produit.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant, // Slightly muted color
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}