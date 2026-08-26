import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customtext({
  required String text,
  required double fontSize,
  required color,
  FontWeight fw = FontWeight.w500,

  TextDecoration? decoration,
  Color? decorationColor,
  List<Shadow>? shadows,
}) {
  return Text(
    text,
    style: GoogleFonts.homenaje(
      fontSize: fontSize,
      fontWeight: fw,
      color: color ?? Colors.black,
      decoration: decoration,
      decorationColor: decorationColor,
      shadows: shadows,
    ),
  );
}
