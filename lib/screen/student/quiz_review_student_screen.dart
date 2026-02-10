import 'package:flutter/material.dart';

import '../../model/subject_model.dart';

class QuizReviewScreen extends StatelessWidget {
  final List<Question> questions;
  final String quizTitle;

  const QuizReviewScreen({
    super.key,
    required this.questions,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    // Hitung Skor Sederhana
    int correctCount = questions
        .where((q) => q.selectedOption == q.correctAnswer)
        .length;
    int wrongCount = questions.length - correctCount;
    int score = ((correctCount / questions.length) * 100).toInt();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(quizTitle, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Nilai (Image f50575)
          _buildScoreHeader(score, correctCount, wrongCount),
          const SizedBox(height: 20),
          // List Soal & Penjelasan (Image f505ad)
          ...questions.asMap().entries.map((entry) {
            return _buildReviewCard(entry.value, entry.key + 1);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildScoreHeader(int score, int correct, int wrong) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Nilai",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                "$score / 100",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildStatIcon(
                Icons.check_circle_outline,
                Colors.green,
                correct.toString(),
              ),
              const SizedBox(width: 15),
              _buildStatIcon(Icons.highlight_off, Colors.red, wrong.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, Color color, String value) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        Text(
          value,
          style: TextStyle(color: color, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Question question, int number) {
    bool isCorrect = question.selectedOption == question.correctAnswer;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(
            color: isCorrect ? Colors.green : Colors.red,
            width: 6,
          ), // Indikator samping
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildTag(
                      "Soal $number",
                      isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                      isCorrect ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    _buildTag(
                      "Pilihan Ganda",
                      Colors.grey.shade100,
                      Colors.grey,
                    ),
                  ],
                ),
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Pertanyaan:",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              question.questionText,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 16),
            const Text(
              "Pilihan Jawaban:",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
              child: Text(
                question.selectedOption ?? "Tidak dijawab",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Penjelasan:",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                question.explanation,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontSize: 11,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
