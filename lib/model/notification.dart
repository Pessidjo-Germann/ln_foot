// Data Model for Notification
import 'package:flutter/widgets.dart';

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