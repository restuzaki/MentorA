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
  final String title;
  final DateTime date;
  final String duration;
  final String questionCountLabel;
  bool isStarted;
  bool isCompleted;
  final List<Question> questions;

  Exam({
    required this.title,
    required this.date,
    required this.duration,
    required this.questionCountLabel,
    required this.questions,
    this.isStarted = false,
    this.isCompleted = false,
  });
}

class Question {
  final String id;
  final String questionText;
  final String type;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  String? selectedOption;

  Question({
    required this.id,
    required this.questionText,
    required this.type,
    this.options = const [],
    required this.correctAnswer,
    required this.explanation,
    this.selectedOption,
  });
}
