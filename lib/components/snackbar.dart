import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final BuildContext context;
  const CustomSnackBar({super.key, required this.message, required this.context});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 4),
      content: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: DefaultColors.danger,
          boxShadow: const [
            BoxShadow(
              color: DefaultColors.neutral,
              blurRadius: 8.0,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: DefaultColors.neutral, width: 1),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: DefaultColors.whiteText,
            backgroundColor: DefaultColors.danger,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
