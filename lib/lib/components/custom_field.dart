import 'package:flutter/material.dart';

Widget customAuthfield({
  required dynamic controller,
  required double? hint,
  double? height,
  double? width
} ){
  String? label;
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      decoration:InputDecoration(
     
       labelText: label,
              filled: true,
        border: OutlineInputBorder(
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
        ),
      )
    ),
  );
}