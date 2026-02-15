import 'package:flutter/material.dart';
import 'package:mentor_a/model/student_grade_model.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Card widget displaying individual student grade information
class StudentGradeCard extends StatelessWidget {
  final StudentGrade grade;
  final VoidCallback onViewDetail;

  const StudentGradeCard({
    super.key,
    required this.grade,
    required this.onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.05),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Left side: Student info and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Student name
                  Text(
                    grade.studentName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Status badge with checkmark/warning icon
                  Row(
                    children: [
                      Icon(
                        grade.hasSubmitted
                            ? Icons.check_circle_outline
                            : Icons.error_outline,
                        size: 16,
                        color: grade.hasSubmitted
                            ? CustomColor.successGreen
                            : CustomColor.errorRed,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        grade.status.displayName,
                        style: TextStyle(
                          fontSize: 12,
                          color: grade.hasSubmitted
                              ? CustomColor.successGreen
                              : CustomColor.errorRed,
                        ),
                      ),
                    ],
                  ),
                  // Submission time (if submitted)
                  if (grade.hasSubmitted && grade.submissionTime != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      grade.submissionTimeDisplay,
                      style: const TextStyle(
                        fontSize: 12,
                        color: CustomColor.textGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Score display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: grade.hasSubmitted
                    ? const Color(0xFFD1F2DD) // Light green
                    : const Color(0xFFE0E0E0), // Light grey
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                grade.scoreDisplay,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: grade.hasSubmitted
                      ? CustomColor.successGreen
                      : CustomColor.textGrey,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // View detail button
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.description_outlined, size: 18),
                color: Colors.white,
                onPressed: onViewDetail,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
