import 'package:flutter/material.dart';
import 'package:ln_foot/theme/app_theme.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Widget? icon;
  final Color? buttonColor;
  final Color? textColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.buttonColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final ButtonStyle defaultStyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      foregroundColor: widget.textColor,
    );

    Widget buttonChild = widget.isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.isOutlined ? (widget.buttonColor ?? kAppOrangeColor) : Colors.white,
              ),
            ),
          )
        : widget.icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.icon!,
                  const SizedBox(width: 8),
                  Text(widget.text),
                ],
              )
            : Text(widget.text);

    if (widget.isOutlined) {
      final outlinedStyle = theme.outlinedButtonTheme.style ??
          OutlinedButton.styleFrom(
            side: BorderSide(color: widget.buttonColor ?? kAppOrangeColor),
          );

      final effectiveStyle = defaultStyle.merge(outlinedStyle);

      return OutlinedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: effectiveStyle,
        child: buttonChild,
      );
    } else {
      final elevatedStyle = theme.elevatedButtonTheme.style ??
          ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor ?? kAppOrangeColor,
          );

      final effectiveStyle = defaultStyle.merge(elevatedStyle);

      return ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            widget.buttonColor ?? kAppOrangeColor,
          ),
        ),
        child: buttonChild,
      );
    }
  }
}
