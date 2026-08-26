import 'package:flutter/material.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

Widget actionButton(IconData icon, String label) {
  return Column(
    children: [
      Container(
        width: 90,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.deepblue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 32, color: AppColors.darkblue),
      ),
      SizedBox(height: 8),
      Text(label, style: TextStyle(fontSize: 12)),
    ],
  );
}
