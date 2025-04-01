import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions; 
  final VoidCallback? onBackButtonPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,  
    this.onBackButtonPressed, 
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;

    final backgroundColor =
        appBarTheme.backgroundColor ?? theme.colorScheme.background;
    final foregroundColor =
        appBarTheme.foregroundColor ?? theme.colorScheme.onBackground;
    final titleTextStyle = appBarTheme.titleTextStyle ??
        theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        );
    final iconTheme = appBarTheme.iconTheme ??
        theme.iconTheme.copyWith(color: foregroundColor);

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: appBarTheme.elevation ?? 0,
      automaticallyImplyLeading:
          false, // Désactivé car nous utilisons un bouton personnalisé
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
              onPressed: onBackButtonPressed,
            )
          : null,
      iconTheme: iconTheme,
      title: Text(
        title,
        style: titleTextStyle,
      ),
      centerTitle: true,
      actions: actions, // Pass actions to the AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
