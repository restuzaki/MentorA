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
  final List<MaterialItem> items;

  Chapter({
    required this.chapterNumber,
    required this.title,
    this.status = "",
    this.summary = "",
    required this.items,
    this.quizzes = const [],
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
  String? selectedOption;

  Quiz({
    required this.title,
    required this.date,
    required this.questionCount,
    this.selectedOption,
  });
}

class Question {
  final String id;
  final String questionText;
  final List<String> options;
  String? selectedOption;
  final String correctAnswer;
  final String explanation;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.selectedOption,
  });
}
