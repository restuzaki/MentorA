class ExamResultModel {
  final String title;
  final String date;
  final int participantCount;
  final int averageScore;
  final String scoreRange;

  ExamResultModel({
    required this.title,
    required this.date,
    required this.participantCount,
    required this.averageScore,
    required this.scoreRange,
  });
}
