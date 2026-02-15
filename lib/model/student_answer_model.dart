/// Model for student's answer to a question
class StudentAnswer {
  final String id;
  final int questionNumber;
  final String questionType; // "Pilihan Ganda" or "Essay"
  final int points;
  final String questionText;
  final String studentAnswer;
  final String? correctAnswer; // Null for essay questions
  final bool isCorrect;

  StudentAnswer({
    required this.id,
    required this.questionNumber,
    required this.questionType,
    required this.points,
    required this.questionText,
    required this.studentAnswer,
    this.correctAnswer,
    required this.isCorrect,
  });

  String get questionLabel => 'Soal $questionNumber';
  String get pointsLabel => '$points point';
}

/// Summary of student's exam results
class ExamResultSummary {
  final int totalScore;
  final int maxScore;
  final int correctCount;
  final int incorrectCount;

  ExamResultSummary({
    required this.totalScore,
    required this.maxScore,
    required this.correctCount,
    required this.incorrectCount,
  });

  String get scoreDisplay => '$totalScore / $maxScore';

  factory ExamResultSummary.fromAnswers(List<StudentAnswer> answers) {
    final correct = answers.where((a) => a.isCorrect).toList();
    final incorrect = answers.where((a) => !a.isCorrect).toList();
    final total = correct.fold<int>(0, (sum, answer) => sum + answer.points);
    final max = answers.fold<int>(0, (sum, answer) => sum + answer.points);

    return ExamResultSummary(
      totalScore: total,
      maxScore: max,
      correctCount: correct.length,
      incorrectCount: incorrect.length,
    );
  }
}
