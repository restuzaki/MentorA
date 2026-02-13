import 'package:flutter/material.dart';

class Subject {
  final String name;
  final String grade;
  final List<Chapter> chapters;

  Subject(this.name, this.grade, this.chapters);
}

class Chapter {
  final String chapterNumber;
  final String title;
  final String status;
  final String summary;
  final List<Quiz> quizzes;
  final List<Exam> exams;
  final List<MaterialItem> items;

  Chapter({
    required this.chapterNumber,
    required this.title,
    this.status = "",
    this.summary = "",
    required this.items,
    this.quizzes = const [],
    this.exams = const [],
  });
}

class MaterialItem {
  final String title;
  final String subtitle;
  final IconData? icon;
  final Color? iconColor;

  MaterialItem({
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconColor,
  });
}

class Quiz {
  final String title;
  final String date;
  final int questionCount;
  bool isCompleted;
  final List<Question> questions;

  Quiz({
    required this.title,
    required this.date,
    required this.questionCount,
    required this.questions,
    this.isCompleted = false,
  });
}

class Exam {
  final String id;
  final String title;
  final DateTime date;
  final int duration; // in minutes
  final int questionCount;
  final String? subjectName;
  final String? className;
  bool isStarted;
  bool isCompleted;
  final List<Question> questions;

  Exam({
    required this.id,
    required this.title,
    required this.date,
    required this.duration,
    required this.questionCount,
    this.subjectName,
    this.className,
    required this.questions,
    this.isStarted = false,
    this.isCompleted = false,
  });

  String get durationLabel => '$duration menit';
  String get questionCountLabel => '$questionCount Soal';
}

class Question {
  final String id;
  final String questionText;
  final QuestionType type;
  final List<AnswerOption> options; // For multiple choice
  final String correctAnswer; // For essay or option ID for multiple choice
  final String explanation;
  String? selectedOption;

  Question({
    required this.id,
    required this.questionText,
    required this.type,
    this.options = const [],
    required this.correctAnswer,
    this.explanation = '',
    this.selectedOption,
  });

  bool get isMultipleChoice => type == QuestionType.multipleChoice;
  bool get isEssay => type == QuestionType.essay;
}

enum QuestionType {
  essay,
  multipleChoice;

  String get displayName {
    switch (this) {
      case QuestionType.essay:
        return 'Essay';
      case QuestionType.multipleChoice:
        return 'Pilihan Ganda';
    }
  }
}

class AnswerOption {
  final String id;
  final String label; // A, B, C, D
  final String text;

  AnswerOption({required this.id, required this.label, required this.text});
}
