import 'package:campus_cart/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String labelText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final IconData? icon;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<T>(
        initialValue: value,
        dropdownColor: DefaultColors.whiteText,
        items: items,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon != null
              ? Icon(icon, color: DefaultColors.primary)
              : null,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: DefaultColors.primary, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
      ),
    );
  }
}
