import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final bool readOnly;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.keyboardType,
    required this.obscureText,
    required this.icon,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(),
        keyboardType: keyboardType,
        readOnly: readOnly,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          errorMaxLines: 5,
          prefixIcon: Icon(icon, color: DefaultColors.primary),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: DefaultColors.primary, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
