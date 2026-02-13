import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Badge displaying the count of exams (similar to StudentCountBadge)
class ExamCountBadge extends StatelessWidget {
  final int examCount;

  const ExamCountBadge({super.key, required this.examCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: CustomColor.lightAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Daftar Ulangan ($examCount)',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: CustomColor.primaryColor,
        ),
      ),
    );
  }
}
