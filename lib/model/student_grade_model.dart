/// Model for student grade information
class StudentGrade {
  final String id;
  final String studentName;
  final double? score; // Nullable for students who haven't submitted
  final DateTime? submissionTime;
  final SubmissionStatus status;

  StudentGrade({
    required this.id,
    required this.studentName,
    this.score,
    this.submissionTime,
    required this.status,
  });

  bool get hasSubmitted => status == SubmissionStatus.submitted;

  String get scoreDisplay {
    if (score == null) return '-';
    return score!.toInt().toString();
  }

  String get submissionTimeDisplay {
    if (submissionTime == null) return '';
    return '${submissionTime!.year}-${submissionTime!.month.toString().padLeft(2, '0')}-${submissionTime!.day.toString().padLeft(2, '0')} ${submissionTime!.hour.toString().padLeft(2, '0')}:${submissionTime!.minute.toString().padLeft(2, '0')}';
  }
}

/// Submission status enum
enum SubmissionStatus {
  submitted,
  notSubmitted;

  String get displayName {
    switch (this) {
      case SubmissionStatus.submitted:
        return 'Dikumpulkan';
      case SubmissionStatus.notSubmitted:
        return 'Belum dikerjakan';
    }
  }
}

/// Summary statistics for grades
class GradeSummary {
  final double averageScore;
  final int totalStudents;
  final int submittedCount;
  final int pendingCount;

  GradeSummary({
    required this.averageScore,
    required this.totalStudents,
    required this.submittedCount,
    required this.pendingCount,
  });

  String get averageScoreDisplay => averageScore.toInt().toString();

  factory GradeSummary.fromGrades(List<StudentGrade> grades) {
    final submitted = grades.where((g) => g.hasSubmitted).toList();
    final pending = grades.where((g) => !g.hasSubmitted).toList();

    double average = 0;
    if (submitted.isNotEmpty) {
      final total = submitted.fold<double>(
        0,
        (sum, grade) => sum + (grade.score ?? 0),
      );
      average = total / submitted.length;
    }

    return GradeSummary(
      averageScore: average,
      totalStudents: grades.length,
      submittedCount: submitted.length,
      pendingCount: pending.length,
    );
  }
}
