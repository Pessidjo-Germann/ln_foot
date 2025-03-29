import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

// Data Model for Notification
class NotificationModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final String dateGroup; // e.g., "Aujourd'hui", "Hier", "15 juin 2024"

  NotificationModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.dateGroup,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Placeholder data - replace with actual data fetching logic
  final List<NotificationModel> _notifications = [
    NotificationModel(
      icon: Icons.local_offer_outlined,
      title: '30% de réduction spéciale !',
      subtitle: 'Promotion spéciale valable uniquement aujourd\'hui.',
      dateGroup: 'Aujourd\'hui',
    ),
    NotificationModel(
      icon: Icons.account_balance_wallet_outlined,
      title: 'Rechargez votre portefeuille électronique avec succès !',
      subtitle: 'Vous avez rechargé votre portefeuille électronique.',
      dateGroup: 'Hier',
    ),
    NotificationModel(
      icon: Icons.location_on_outlined,
      title: 'Nouveau service disponible !',
      subtitle: 'Vous pouvez désormais suivre votre commande en temps réel.',
      dateGroup: 'Hier',
    ),
    NotificationModel(
      icon: Icons.credit_card_outlined,
      title: 'Carte de crédit connectée !',
      subtitle: 'La carte de crédit a été liée.',
      dateGroup: '15 juin 2024',
    ),
    NotificationModel(
      icon: Icons.person_outline,
      title: 'Configuration du compte réussie !',
      subtitle: 'Votre compte a été créé.',
      dateGroup: '15 juin 2024',
    ),
  ];

  // Group notifications by date
  Map<String, List<NotificationModel>> _groupNotificationsByDate(
      List<NotificationModel> notifications) {
    final Map<String, List<NotificationModel>> grouped = {};
    for (var notification in notifications) {
      if (!grouped.containsKey(notification.dateGroup)) {
        grouped[notification.dateGroup] = [];
      }
      grouped[notification.dateGroup]!.add(notification);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = _groupNotificationsByDate(_notifications);
    final dateGroups = groupedNotifications.keys.toList();
    final bool isEmpty = _notifications.isEmpty; // Change this to test empty state

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
        showBackButton: true, // Assuming back button is needed
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black54), // Match back button color for consistency
            onPressed: () {
              // TODO: Implement notification settings action
              print('Notification settings tapped');
            },
          ),
          const SizedBox(width: 8), // Add some padding to the right
        ],
      ),
      body: isEmpty
          ? const _EmptyNotificationsView()
          : _NotificationListView(
              groupedNotifications: groupedNotifications,
              dateGroups: dateGroups,
            ),
    );
  }
}

// Widget for the Empty State
class _EmptyNotificationsView extends StatelessWidget {
  const _EmptyNotificationsView();

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

// Widget for the List of Notifications
class _NotificationListView extends StatelessWidget {
  final Map<String, List<NotificationModel>> groupedNotifications;
  final List<String> dateGroups;

  const _NotificationListView({
    required this.groupedNotifications,
    required this.dateGroups,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dateGroups.length,
      itemBuilder: (context, index) {
        final dateGroup = dateGroups[index];
        final notificationsInGroup = groupedNotifications[dateGroup]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateHeader(title: dateGroup),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
              shrinkWrap: true, // Fit content
              itemCount: notificationsInGroup.length,
              itemBuilder: (context, itemIndex) {
                final notification = notificationsInGroup[itemIndex];
                return _NotificationItem(notification: notification);
              },
              separatorBuilder: (context, itemIndex) => Divider(
                height: 1,
                thickness: 1,
                indent: 64, // Indent to align with text
                color: Colors.grey[200],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Widget for Date Headers (e.g., "Aujourd'hui")
class _DateHeader extends StatelessWidget {
  final String title;

  const _DateHeader({required this.title});

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


// Widget for a Single Notification Item
class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationItem({required this.notification});

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
