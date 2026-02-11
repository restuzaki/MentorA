import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// A badge displaying student count with a "Tambah" button.
class StudentCountBadge extends StatelessWidget {
  final int studentCount;

  const StudentCountBadge({super.key, required this.studentCount});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Total Murid ($studentCount)',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: CustomColor.textBlack,
      ),
    );
  }
}
