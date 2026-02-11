class ClassHistoryModel {
  final String className;
  final String subject;
  final int studentCount;
  final int averageScore;
  final double percentageChange;
  final bool isIncrease;
  final String lastUpdate;

  ClassHistoryModel({
    required this.className,
    required this.subject,
    required this.studentCount,
    required this.averageScore,
    required this.percentageChange,
    required this.isIncrease,
    required this.lastUpdate,
  });
}
