
// Widget for the List of Notifications
import 'package:flutter/material.dart';
import 'package:ln_foot/model/notification.dart';
import 'package:ln_foot/widgets/notification/date_header.dart';
import 'package:ln_foot/widgets/notification/notification_item.dart';

class NotificationListView extends StatelessWidget {
  final Map<String, List<NotificationModel>> groupedNotifications;
  final List<String> dateGroups;

  const NotificationListView({
    super.key,
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
            DateHeader(title: dateGroup),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
              shrinkWrap: true, // Fit content
              itemCount: notificationsInGroup.length,
              itemBuilder: (context, itemIndex) {
                final notification = notificationsInGroup[itemIndex];
                return NotificationItem(notification: notification);
              },
              separatorBuilder: (context, itemIndex) => Divider(
                height: 1,
               thickness: 0.4,
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