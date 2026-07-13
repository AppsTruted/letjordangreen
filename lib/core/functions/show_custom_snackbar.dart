import 'package:flutter/material.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';

void showAppSnackBar(
    BuildContext context, {
      required String message,
      Color backgroundColor = AppColors.primaryColor,
      Duration duration = const Duration(seconds: 3),
      SnackBarBehavior behavior = SnackBarBehavior.fixed,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      behavior: behavior,
      duration: duration,
    ),
  );
}
