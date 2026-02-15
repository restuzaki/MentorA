import 'package:flutter/material.dart';
import 'package:mentor_a/model/subject_model.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Card widget for displaying a question in the question list
class QuestionCard extends StatelessWidget {
  final int questionNumber;
  final Question question;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const QuestionCard({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.onEdit,
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
            // Header with badges and actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Question number badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Soal $questionNumber',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Question type badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        question.type.displayName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ),
                  ],
                ),
                // Action buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit button
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        color: CustomColor.primaryColor,
                        onPressed: onEdit,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Delete button
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(8),
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
              ],
            ),
            const SizedBox(height: 16),
            // Question text with label
            const Text(
              'Pertanyaan:',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 14,
                color: CustomColor.textBlack,
                height: 1.5,
              ),
            ),
            // Show options for multiple choice
            if (question.isMultipleChoice && question.options.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Pilihan Jawaban:',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              ...question.options.map((option) {
                final isCorrect = option.id == question.correctAnswer;
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? const Color(0xFFD4F4DD)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isCorrect
                          ? const Color(0xFF4CAF50)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${option.label}. ${option.text}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isCorrect
                          ? const Color(0xFF2E7D32)
                          : CustomColor.textBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
