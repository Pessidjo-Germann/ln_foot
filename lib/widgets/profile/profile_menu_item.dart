import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor; // Optional color for the icon
  final Color? textColor; // Optional color for the text

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on provided parameters or theme defaults
    final effectiveIconColor = iconColor ?? Theme.of(context).iconTheme.color;
    final effectiveTextColor = textColor ?? Theme.of(context).textTheme.bodyLarge?.color;
    final trailingIconColor = Colors.grey; // Or use theme color

    return ListTile(
      leading: Icon(icon, color: effectiveIconColor, size: 24), // Adjust size as needed
      title: Text(
        title,
        style: TextStyle(
          color: effectiveTextColor,
          fontSize: 16, // Adjust font size as needed
          // fontWeight: FontWeight.w500, // Optional: adjust weight
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: trailingIconColor),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0), // Adjust padding
      visualDensity: VisualDensity.compact, // Make it slightly denser
    );
  }
}
