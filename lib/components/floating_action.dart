import 'package:flutter/material.dart';
import 'package:campus_cart/core/theme/theme.dart';

class FloatingAction extends StatelessWidget {
  final Function()? onPressed;
  const FloatingAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 0,
      backgroundColor: DefaultColors.primary,
      foregroundColor: DefaultColors.background,
      onPressed: onPressed,
      child: Icon(Icons.add, size: 40, color: Colors.white),
    );
  }
}
