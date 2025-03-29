import 'package:flutter/material.dart';
import 'package:ln_foot/model/notification.dart';
import 'package:ln_foot/widgets/notification/empty_notification_view.dart';
import 'package:ln_foot/widgets/notification/notification_list_view.dart';
import '../widgets/custom_app_bar.dart';

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
    final bool isEmpty =
        _notifications.isEmpty; // Change this to test empty state

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
        showBackButton: true, // Assuming back button is needed
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined,
                color:
                    Colors.black54), // Match back button color for consistency
            onPressed: () {
              print('Notification settings tapped');
            },
          ),
          const SizedBox(width: 8), // Add some padding to the right
        ],
      ),
      body: isEmpty
          ? const EmptyNotificationsView()
          : NotificationListView(
              groupedNotifications: groupedNotifications,
              dateGroups: dateGroups,
            ),
    );
  }
}
