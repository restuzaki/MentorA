import 'package:flutter/material.dart';
import 'package:mentor_a/model/student_answer_model.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/answer_question_card.dart';
import 'package:mentor_a/widget/score_summary_header.dart';

/// Screen displaying detailed answers for a student's exam
class DetailedAnswerScreen extends StatefulWidget {
  final String studentName;
  final String examTitle;

  const DetailedAnswerScreen({
    super.key,
    required this.studentName,
    required this.examTitle,
  });

  @override
  State<DetailedAnswerScreen> createState() => _DetailedAnswerScreenState();
}

class _DetailedAnswerScreenState extends State<DetailedAnswerScreen> {
  List<StudentAnswer> _answers = [];
  late ExamResultSummary _summary;

  @override
  void initState() {
    super.initState();
    _loadAnswers();
  }

  void _loadAnswers() {
    // Sample data - in real app, this would come from a database
    _answers = [
      StudentAnswer(
        id: '1',
        questionNumber: 1,
        questionType: 'Pilihan Ganda',
        points: 4,
        questionText: 'Tentukan hasil dari 2x + 5 = 15',
        studentAnswer: 'A. x = 5',
        correctAnswer: 'A. x = 5',
        isCorrect: true,
      ),
      StudentAnswer(
        id: '2',
        questionNumber: 2,
        questionType: 'Pilihan Ganda',
        points: 4,
        questionText: 'Sederhanakan 3(x + 2) - 2x',
        studentAnswer: 'C. x + 6',
        correctAnswer: 'C. x + 6',
        isCorrect: true,
      ),
      StudentAnswer(
        id: '3',
        questionNumber: 3,
        questionType: 'Pilihan Ganda',
        points: 4,
        questionText: 'Jika f(x) = 2x + 3, maka f(5) = ?',
        studentAnswer: 'A. 13',
        correctAnswer: 'A. 13',
        isCorrect: true,
      ),
      StudentAnswer(
        id: '4',
        questionNumber: 4,
        questionType: 'Pilihan Ganda',
        points: 4,
        questionText: 'Faktorkan x² - 9',
        studentAnswer: 'D. (x-3)(x+3)',
        correctAnswer: 'D. (x-3)(x+3)',
        isCorrect: true,
      ),
      StudentAnswer(
        id: '5',
        questionNumber: 5,
        questionType: 'Pilihan Ganda',
        points: 4,
        questionText: 'Hitung nilai x dari 5x - 10 = 0',
        studentAnswer: 'C. x = 3',
        correctAnswer: 'B. x = 2',
        isCorrect: false,
      ),
    ];

    _summary = ExamResultSummary.fromAnswers(_answers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Detail Jawaban',
          style: TextStyle(
            color: CustomColor.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0.5,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomColor.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Score summary card
          ScoreSummaryCard(summary: _summary),
          // Question count label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar Jawaban (${_answers.length})',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textBlack,
                ),
              ),
            ),
          ),
          // Answer list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _answers.length,
              itemBuilder: (context, index) {
                final answer = _answers[index];
                return AnswerQuestionCard(answer: answer);
              },
            ),
          ),
        ],
      ),
    );
  }
}
