import 'package:flutter/material.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

class MemberCounter extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MemberCounter({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(
          height: screenheight * 0.08,
          width: screenWidth * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.minimize),
            onPressed: count > 1 ? onDecrement : null,
            color: AppColors.black,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Container(
          height: screenheight * 0.08,
          width: screenWidth * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(104, 0, 0, 0)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '$count Person${count > 1 ? 's' : ''}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),

        Container(
          height: screenheight * 0.08,
          width: screenWidth * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: onIncrement,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
