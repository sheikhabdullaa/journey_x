import 'package:flutter/material.dart';

Widget customDropdownField<T>({
  double borderRadius = 14,
  required String hint,
  TextStyle? hintStyle,
  String? label,
  double? height,
  double? width,
  T? value,
  required List<DropdownMenuItem<T>> items,
  required void Function(T?) onChanged,
  
}) {
  return SizedBox(
    height: height,
    width: width,
    child: DropdownButtonFormField<T>(
      // ignore: deprecated_member_use
      value: value,
      onChanged: onChanged,
      items: items,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        hintStyle: hintStyle ?? const TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Color.fromARGB(67, 158, 158, 158),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Color.fromARGB(67, 158, 158, 158),
          ),
        ),
      ),
    ),
  );
}
