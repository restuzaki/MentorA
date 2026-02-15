import 'package:flutter/material.dart';
import 'package:mentor_a/model/subject_model.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:intl/intl.dart';

/// Card widget displaying exam information with action buttons
class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onDetail;
  final VoidCallback onNilai;
  final VoidCallback onDelete;

  const ExamCard({
    super.key,
    required this.exam,
    required this.onDetail,
    required this.onNilai,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and delete button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    exam.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textBlack,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    color: CustomColor.errorRed,
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Exam details
            _buildDetailRow(
              Icons.calendar_today_outlined,
              DateFormat('d MMMM yyyy', 'id_ID').format(exam.date),
            ),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.access_time_outlined, exam.durationLabel),
            const SizedBox(height: 8),
            _buildDetailRow(
              Icons.description_outlined,
              exam.questionCountLabel,
            ),
            const SizedBox(height: 16),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onDetail,
                    icon: const Icon(Icons.description_outlined, size: 16),
                    label: const Text('Detail'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CustomColor.primaryColor,
                      side: const BorderSide(
                        color: CustomColor.primaryColor,
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onNilai,
                    icon: const Icon(Icons.people_outline, size: 16),
                    label: const Text('Nilai'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF9E9E9E)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: Color(0xFF616161)),
        ),
      ],
    );
  }
}
