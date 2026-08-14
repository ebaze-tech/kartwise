import 'package:flutter/material.dart';
import 'package:campus_cart/core/theme/theme.dart';
import 'package:campus_cart/components/button.dart';

class CustomError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const CustomError({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: DefaultColors.error, size: 50),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Button(
            onPressed: onRetry,
            buttonText: 'Refresh',
            isIconButton: false,
            buttonColor: DefaultColors.gray,
          ),
        ],
      ),
    );
  }
}
