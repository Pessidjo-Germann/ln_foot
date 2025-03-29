import 'package:flutter/material.dart';
import 'package:ln_foot/screen/notification_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, // No shadow
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/6224c39f7d13f59b848b4562e7280a8a.png',
            width: 40,
          ),
          const SizedBox(width: 8),
          Text(
            'LN SHOP',
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color ??
                  Colors.black, // Use theme color
              fontWeight: FontWeight.bold,
              fontSize: 18, // Adjust size as needed
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
              Icons.notifications_none_outlined), // Notification icon
          color: Theme.of(context).iconTheme.color ??
              Colors.black, // Use theme color
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationScreen()),
            );
          },
        ),
        const SizedBox(width: 8),
      ],

      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
