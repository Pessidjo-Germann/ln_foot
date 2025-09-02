
import 'package:flutter/material.dart';

class DateHeader extends StatelessWidget {
  final String title;

  const DateHeader({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0, right: 16.0),
      child: Text(
        title,
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurfaceVariant, // Muted color
        ),
      ),
    );
  }
}
