import 'package:flutter/material.dart';
import 'package:ln_foot/theme/app_theme.dart';
 
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Widget? icon; // Keep icon optional
  final Color? buttonColor; // Nouveau paramètre pour la couleur du bouton
  final Color? textColor; // Nouveau paramètre pour la couleur du texte

  // Removed static color constant - should come from theme

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Define base styles using theme properties, allowing overrides from specific themes
    final ButtonStyle defaultStyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      foregroundColor: textColor,
    );

    if (isOutlined) {
      final outlinedStyle = theme.outlinedButtonTheme.style ??
          OutlinedButton.styleFrom(
             //  foregroundColor: textColor ?? kAppOrangeColor,
              // side: BorderSide(color: buttonColor ?? kAppOrangeColor),
              );

      final effectiveStyle = defaultStyle.merge(outlinedStyle);

      return icon != null
          ? OutlinedButton.icon(
              icon: icon!,
              label: Text(text),
              onPressed: onPressed,
              style: effectiveStyle,
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: effectiveStyle,
              child: Text(text),
            );
    } else {
      final elevatedStyle = theme.elevatedButtonTheme.style ??
          ElevatedButton.styleFrom(
               backgroundColor: buttonColor ?? kAppOrangeColor,
              //  foregroundColor: textColor ?? Colors.white,
              );

      final effectiveStyle = defaultStyle.merge(elevatedStyle);

      return icon != null
          ? ElevatedButton.icon(
              icon: icon!,
              label: Text(text),
              onPressed: onPressed,
              style: effectiveStyle,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  buttonColor?? kAppOrangeColor,
                  ),
              ),
              child: Text(text),
            );
    }
  }
}
