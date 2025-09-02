// Widget for a Single Notification Item
import 'package:flutter/material.dart';
import 'package:ln_foot/model/notification.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem( {super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListTile(
      leading: Icon(
        notification.icon,
        color: theme.colorScheme.secondary, // Or a specific color
        size: 28,
      ),
      title: Text(
        notification.title,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600, // Semi-bold
        ),
      ),
      subtitle: Text(
        notification.subtitle,
        style: textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant, // Muted color
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      // Add onTap if notifications are tappable
      // onTap: () {
      //   // Handle notification tap
      // },
    );
  }
}
