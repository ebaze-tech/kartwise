import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final bool isIconButton;
  final VoidCallback onPressed;
  final Color? buttonColor;

  const Button({
    super.key,
    required this.buttonText,
    required this.isIconButton,
    required this.onPressed,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: DefaultColors.whiteText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              if (isIconButton)
                Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: DefaultColors.whiteText,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
