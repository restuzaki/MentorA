import 'package:flutter/material.dart';
import 'package:mentor_a/model/subject_model.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Bottom sheet for selecting question type (Essay or Multiple Choice)
class QuestionTypeBottomSheet extends StatelessWidget {
  final Function(QuestionType) onTypeSelected;

  const QuestionTypeBottomSheet({super.key, required this.onTypeSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: CustomColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Tipe Soal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CustomColor.textBlack,
            ),
          ),
          const SizedBox(height: 20),
          _buildTypeOption(
            context,
            'Essay',
            'Pertanyaan dengan jawaban isi singkat atau panjang',
            Icons.edit_note_outlined,
            QuestionType.essay,
          ),
          const SizedBox(height: 12),
          _buildTypeOption(
            context,
            'Pilihan Ganda',
            'Pertanyaan dengan pilihan jawaban A, B, C, D',
            Icons.list_alt_outlined,
            QuestionType.multipleChoice,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTypeOption(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    QuestionType type,
  ) {
    return InkWell(
      onTap: () {
        onTypeSelected(type);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: CustomColor.borderGrey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColor.lightAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: CustomColor.primaryColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: CustomColor.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: CustomColor.textGrey,
            ),
          ],
        ),
      ),
    );
  }

  static Future<QuestionType?> show(BuildContext context) {
    return showModalBottomSheet<QuestionType>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => QuestionTypeBottomSheet(
        onTypeSelected: (type) => Navigator.pop(context, type),
      ),
    );
  }
}
