import 'package:flutter/material.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,
    this.color = AppColors.primaryColor,
    required this.text,
    this.colorBorder,
    this.height,
    this.radius,
    this.width,
    this.fontSize,
    this.textColor,
    this.icon,           // Add this
    this.iconColor,     // Add this (optional)
    super.key,
  });
  final String? text;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final double? fontSize;
  final Function() onTap;
  final Color? colorBorder;
  final Color? textColor;
  final Widget? icon;           // New parameter for icon
  final Color? iconColor;       // New parameter for icon color

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0.4),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: colorBorder ?? Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(width ?? double.infinity, height ?? 45),
          ),
          backgroundColor: WidgetStateProperty.all(color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,  // Makes button wrap content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              text!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 15,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}