import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final FormFieldValidator<T>? validator;
  final IconData? icon;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<T>(
        style: Theme.of(context).textTheme.bodyMedium,
        initialValue: value,
        dropdownColor: DefaultColors.whiteText,
        items: items,
        onChanged: onChanged,
        validator: validator,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: DefaultColors.primary,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: icon != null
              ? Icon(icon, color: DefaultColors.primary)
              : null,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),

          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: DefaultColors.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DefaultColors.primary.withValues(alpha: 0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: DefaultColors.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),

          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
