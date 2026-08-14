import 'package:flutter/material.dart';

class FloatingAction extends StatelessWidget {
  final Function()? onPressed;
  const FloatingAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 65,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        backgroundColor: Colors.green,
        // foregroundColor: DefaultColors.background,
        onPressed: onPressed,
        child: Icon(Icons.add, size: 55, color: Colors.white),
      ),
    );
  }
}
