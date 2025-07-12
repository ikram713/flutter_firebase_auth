import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color? iconColor;
  final IconData? icon;
  final String? text;
  final Color? textColor;
  final double borderRadius;

  const CustomButtonAuth({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    this.iconColor,
    this.icon,
    this.text,
    this.textColor,
    this.borderRadius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: icon != null ? const EdgeInsets.all(15) : const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      elevation: 0,
      child: icon != null
          ? Icon(icon, color: iconColor, size: 28)
          : Text(
              text ?? '',
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

