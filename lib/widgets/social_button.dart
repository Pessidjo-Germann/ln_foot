import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget icon;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  const SocialButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.foregroundColor = Colors.black87,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: icon,
      label: Text(text),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        side: BorderSide(color: borderColor ?? Colors.grey.shade300),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}