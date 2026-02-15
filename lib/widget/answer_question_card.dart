import 'package:flutter/material.dart';
import 'package:mentor_a/model/student_answer_model.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Card widget displaying a question with student's answer
class AnswerQuestionCard extends StatelessWidget {
  final StudentAnswer answer;

  const AnswerQuestionCard({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    final cardBgColor = answer.isCorrect
        ? const Color(0xFFEFFDF2) // Very light green background
        : const Color(0xFFFFF0F0); // Very light red background

    final borderColor = answer.isCorrect
        ? const Color.fromRGBO(16, 185, 129, 1) // Green border
        : const Color.fromRGBO(239, 68, 68, 1); // Red border

    final badgeColor = answer.isCorrect
        ? const Color(0xFF4CAF50) // Bright green
        : const Color(0xFFF44336); // Bright red

    final answerBgColor = answer.isCorrect
        ? const Color(0xFFD1F2DD) // Light green for answer box
        : const Color(0xFFFFDADA); // Light red for answer box

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section with colored background
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                // Question number badge - more prominent
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    answer.questionLabel,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Question type with larger icon
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: answer.isCorrect
                        ? const Color.fromRGBO(76, 175, 80, 0.1)
                        : const Color.fromRGBO(244, 67, 54, 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    answer.isCorrect ? Icons.check_circle : Icons.cancel,
                    size: 18,
                    color: badgeColor,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  answer.questionType,
                  style: TextStyle(
                    fontSize: 13,
                    color: badgeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Points badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    answer.pointsLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question text
                const Text(
                  'Pertanyaan:',
                  style: TextStyle(
                    fontSize: 11,
                    color: CustomColor.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  answer.questionText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CustomColor.textBlack,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                // Student's answer
                const Text(
                  'Jawaban Murid:',
                  style: TextStyle(
                    fontSize: 11,
                    color: CustomColor.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: answerBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    answer.studentAnswer,
                    style: TextStyle(
                      fontSize: 14,
                      color: badgeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Correct answer (if wrong)
                if (!answer.isCorrect && answer.correctAnswer != null) ...[
                  const SizedBox(height: 14),
                  const Text(
                    'Jawaban Benar:',
                    style: TextStyle(
                      fontSize: 11,
                      color: CustomColor.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1F2DD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      answer.correctAnswer!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColor.successGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
