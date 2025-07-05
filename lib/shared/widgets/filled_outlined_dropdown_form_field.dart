import 'package:flutter/material.dart';
import 'package:pdf_reader/core/theme/colors.dart';

class FilledOutlinedDropdownFormField<T> extends StatelessWidget {
  const FilledOutlinedDropdownFormField({
    required this.items,
    super.key,
    this.value,
    this.label,
    this.hint,
    this.errorText,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? label;
  final String? hint;
  final String? errorText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: greyLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.black),
        errorText: errorText,
      ),
    );
  }
}
