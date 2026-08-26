import 'package:flutter/material.dart';
Widget customTextField({
  double borderRadius = 4,
  required String? hint,
  required Icon? icon,
  TextStyle? hintStyle,
  String? label,
  double? height,
  double? width,
  TextEditingController? controller,
  bool obscureText = false, required bool readOnly,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
         prefixIcon: icon,
        labelText: label,
        hintStyle: hintStyle ??  TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white),

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color.fromARGB(67, 158, 158, 158)),
        ),
      ),
    ),
  );
}
