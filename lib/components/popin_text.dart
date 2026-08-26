import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget popintext({
  required String text,
  required double fontSize,
  required color,
  FontWeight fw = FontWeight.w500,

  TextDecoration? decoration,
  Color? decorationColor,
  List<Shadow>? shadows,
  int maxLines = 1,
  TextOverflow overflow = TextOverflow.ellipsis, // ✅ ADDED
  TextAlign textAlign = TextAlign.start,
}) {
  return Text(
    text,
     maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fw,
      color: color ?? Colors.black,
      decoration: decoration,
      decorationColor: decorationColor,
      shadows: shadows,
    ),
  );
}