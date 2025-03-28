import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final String? helperText;
  final bool isPasswordVisible;
  final VoidCallback? onVisibilityToggle;
  final String? Function(String?)? validator;

  // Removed static color constant - should come from theme

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.helperText,
    this.isPasswordVisible = false,
    this.onVisibilityToggle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // Get the base decoration from the theme, or create a default if none exists
    final baseDecoration = theme.inputDecorationTheme;

    // Define a default border style if not provided by the theme
    final defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorScheme.outline), // Use theme outline color
    );

    // Define colors based on the theme
    final iconColor = colorScheme.onSurface.withOpacity(0.6); // Example color for icons/labels
    final focusedBorderColor = colorScheme.primary;
    final errorColor = colorScheme.error;

    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        // Apply theme defaults first
        // labelText: labelText, // Prefer label over labelText if using floating labels
        label: Text(labelText), // Use label for better animation
        hintText: hintText,
        helperText: helperText,
        // Use styles from theme or fallback to defaults using theme colors
        labelStyle: baseDecoration.labelStyle ?? TextStyle(color: iconColor),
        floatingLabelStyle: baseDecoration.floatingLabelStyle ?? TextStyle(color: focusedBorderColor), // Color when focused
        helperStyle: baseDecoration.helperStyle ?? TextStyle(color: iconColor),
        hintStyle: baseDecoration.hintStyle ?? TextStyle(color: iconColor),
        errorStyle: baseDecoration.errorStyle ?? TextStyle(color: errorColor),
        // Define borders using theme or defaults, overriding colors
        border: baseDecoration.border ?? defaultInputBorder,
        enabledBorder: baseDecoration.enabledBorder ?? defaultInputBorder,
        focusedBorder: baseDecoration.focusedBorder?.copyWith(borderSide: BorderSide(color: focusedBorderColor))
            ?? defaultInputBorder.copyWith(borderSide: BorderSide(color: focusedBorderColor)),
        errorBorder: baseDecoration.errorBorder?.copyWith(borderSide: BorderSide(color: errorColor))
            ?? defaultInputBorder.copyWith(borderSide: BorderSide(color: errorColor)),
        focusedErrorBorder: baseDecoration.focusedErrorBorder?.copyWith(borderSide: BorderSide(color: errorColor, width: 2))
            ?? defaultInputBorder.copyWith(borderSide: BorderSide(color: errorColor, width: 2)),
        // Use theme color for suffix icon
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: iconColor, // Use theme-derived icon color
                ),
                onPressed: onVisibilityToggle,
              )
            : null,
        // Ensure consistent content padding from theme or default
        contentPadding: baseDecoration.contentPadding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
      validator: validator,
    );
  }
}
