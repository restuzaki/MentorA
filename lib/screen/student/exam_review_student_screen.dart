import 'package:flutter/material.dart';
import '../../model/subject_model.dart';

class ExamReviewScreen extends StatefulWidget {
  final List<Question> questions;
  final String examTitle;
  const ExamReviewScreen({
    super.key,
    required this.questions,
    required this.examTitle,
  });

  @override
  State<ExamReviewScreen> createState() => _ExamReviewScreenState();
}

class _ExamReviewScreenState extends State<ExamReviewScreen> {
  int _currentPage = 0;
  final int _itemsPerPage = 3; // DISAMAKAN DENGAN QUESTION SCREEN

  List<Question> get _currentQuestions {
    int start = _currentPage * _itemsPerPage;
    int end = start + _itemsPerPage;
    return widget.questions.sublist(
      start,
      end > widget.questions.length ? widget.questions.length : end,
    );
  }

  bool get _isLastPage =>
      (_currentPage + 1) * _itemsPerPage >= widget.questions.length;

  @override
  Widget build(BuildContext context) {
    int correctCount = widget.questions
        .where((q) => q.isMultipleChoice && q.selectedOption == q.correctAnswer)
        .length;
    int wrongCount = widget.questions
        .where((q) => q.isMultipleChoice && q.selectedOption != q.correctAnswer)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.examTitle,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_currentPage == 0) ...[
                  _buildScoreHeader(correctCount, wrongCount),
                  const SizedBox(height: 20),
                ],
                ..._currentQuestions.asMap().entries.map((entry) {
                  int globalIndex =
                      (_currentPage * _itemsPerPage) + entry.key + 1;
                  return _buildReviewCard(entry.value, globalIndex);
                }),
              ],
            ),
          ),
          _buildBottomNav(context),
        ],
      ),
    );
  }

  Widget _buildScoreHeader(int correct, int wrong) {
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
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 4),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 28),
                  children: [
                    TextSpan(
                      text: "-- ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "/ 100",
                      style: TextStyle(fontSize: 24, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildStatIcon(
                Icons.check_circle_outline,
                const Color(0xFF2ECC71),
                correct.toString(),
              ),
              const SizedBox(width: 20),
              _buildStatIcon(
                Icons.highlight_off,
                const Color(0xFFE74C3C),
                wrong.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, Color color, String value) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Question question, int number) {
    bool isEssay = question.isEssay;
    bool isCorrect =
        !isEssay && (question.selectedOption == question.correctAnswer);
    Color themeColor = isEssay
        ? Colors.grey
        : (isCorrect ? const Color(0xFF2ECC71) : const Color(0xFFE74C3C));
    Color bgColor = isEssay
        ? Colors.white
        : (isCorrect ? const Color(0xFFE9F7EF) : const Color(0xFFFDEDEC));

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: themeColor, width: 6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                      themeColor.withValues(alpha: 0.1),
                      themeColor,
                    ),
                    const SizedBox(width: 8),
                    _buildTag(
                      question.type.displayName,
                      Colors.grey.shade100,
                      Colors.grey.shade600,
                    ),
                  ],
                ),
                _buildTag(
                  isEssay ? "0 poin" : "4 poin",
                  themeColor.withValues(alpha: 0.1),
                  themeColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Pertanyaan:",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            Text(
              question.questionText,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 16),
            const Text(
              "Jawaban:",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isEssay ? Colors.white : bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isEssay ? Colors.grey.shade300 : themeColor,
                ),
              ),
              child: Text(
                question.selectedOption ?? "Tidak dijawab",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isEssay ? Colors.black87 : themeColor,
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _currentPage == 0
                  ? null
                  : () => setState(() => _currentPage--),
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentPage == 0
                    ? const Color(0xFFA6C1E9)
                    : const Color(0xFF4A89DC),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Sebelumnya",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_isLastPage) {
                  Navigator.pop(context);
                } else {
                  setState(() => _currentPage++);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A89DC),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _isLastPage ? "Akhiri Review" : "Selanjutnya",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
