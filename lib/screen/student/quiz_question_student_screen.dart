import 'package:flutter/material.dart';
import 'package:mentor_a/screen/student/quiz_review_student_screen.dart';
import 'package:mentor_a/style/custom_color.dart';

import '../../model/subject_model.dart';
import '../../widget/custom_button.dart';

class QuizQuestionStudentScreen extends StatefulWidget {
  final String quizTitle;
  const QuizQuestionStudentScreen({super.key, required this.quizTitle});

  @override
  State<QuizQuestionStudentScreen> createState() =>
      _QuizQuestionStudentScreenState();
}

class _QuizQuestionStudentScreenState extends State<QuizQuestionStudentScreen> {
  // Data Dummy Soal sesuai gambar
  final List<Question> _questions = [
    Question(
      id: "1",
      questionText: "Tentukan nilai x dari persamaan berikut:\n2x + 6 = 14",
      options: ["A. 3", "B. 4", "C. 5", "D. 6"],
      correctAnswer: "B. 4",
      explanation:
          "Cara: 2x + 6 = 14\nKurangi 6 di kedua ruas: 2x = 8\nBagi 2: x = 4",
    ),
    Question(
      id: "2",
      questionText: "Tentukan nilai x dari persamaan berikut:\n5x - 10 = 0",
      options: ["A. 1", "B. 2", "C. 3", "D. 4"],
      correctAnswer: "B. 2",
      explanation:
          "Cara: 5x - 10 = 0\nKurangi 10 di kedua ruas: 5x = 10\nBagi 5: x = 2",
    ),
    Question(
      id: "3",
      questionText: "Tentukan nilai x dari persamaan berikut:\nx + 7 = 12",
      options: ["A. 3", "B. 4", "C. 5", "D. 6"],
      correctAnswer: "C. 5",
      explanation: "Cara: x + 7 = 12\nKurangi 7 di kedua ruas: x = 5",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.quizTitle,
          style: const TextStyle(color: Colors.black),
        ),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _questions.length + 1, // +1 untuk tombol kumpulkan
        itemBuilder: (context, index) {
          // Jika index terakhir, tampilkan tombol kumpulkan
          if (index == _questions.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: CustomChoiceButton(
                text: "Kumpulkan",
                backgroundColor: CustomColor.primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text("Kumpulkan Kuis?"),
                      content: const Text(
                        "Apakah kamu yakin ingin mengumpulkan jawabanmu sekarang?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Batal",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Tutup dialog
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizReviewScreen(
                                  questions: _questions,
                                  quizTitle: widget.quizTitle,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Ya, Kumpulkan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          final question = _questions[index];
          return _buildQuestionCard(question, index + 1);
        },
      ),
    );
  }

  Widget _buildQuestionCard(Question question, int number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTag(
                "Soal $number",
                const Color(0xFFE8F0FE),
                CustomColor.primaryColor,
              ),
              const SizedBox(width: 8),
              _buildTag("Pilihan Ganda", Colors.grey.shade100, Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Pertanyaan:",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            question.questionText,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            "Pilihan Jawaban:",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          // Loop pilihan jawaban
          ...question.options.map((option) {
            bool isSelected = question.selectedOption == option;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    question.selectedOption = option;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    // Warna berubah jika dipilih (Biru muda) atau tetap putih/abu
                    color: isSelected
                        ? const Color(0xFFE8F0FE)
                        : const Color(0xFFF1F3F5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? CustomColor.primaryColor
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected
                          ? CustomColor.primaryColor
                          : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
