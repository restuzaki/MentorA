import 'package:flutter/material.dart';
import 'package:mentor_a/model/class_history_model.dart';
import 'package:mentor_a/screen/teacher/class_history_detail_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/class_history_card.dart';

class ClassHistoryScreen extends StatelessWidget {
  const ClassHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ClassHistoryModel> history = [
      ClassHistoryModel(
        className: "Kelas 10A",
        subject: "Matematika",
        studentCount: 32,
        averageScore: 85,
        percentageChange: 5,
        isIncrease: true,
        lastUpdate: "5 Jun 2025",
      ),
      ClassHistoryModel(
        className: "Kelas 10B",
        subject: "Matematika",
        studentCount: 30,
        averageScore: 83,
        percentageChange: 3,
        isIncrease: true,
        lastUpdate: "5 Jun 2025",
      ),
      ClassHistoryModel(
        className: "Kelas 11A",
        subject: "Fisika",
        studentCount: 28,
        averageScore: 88,
        percentageChange: 6,
        isIncrease: true,
        lastUpdate: "5 Jun 2025",
      ),
      ClassHistoryModel(
        className: "Kelas 12A",
        subject: "Bahasa Indonesia",
        studentCount: 35,
        averageScore: 91,
        percentageChange: 2,
        isIncrease: false,
        lastUpdate: "5 Jun 2025",
      ),
    ];

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text("Riwayat Perkelas"),
        backgroundColor: CustomColor.backgroundColor,
        surfaceTintColor: CustomColor.backgroundColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ClassHistoryCard(
            model: item,
            color: item.subject == "Matematika"
                ? CustomColor.accentColor
                : item.subject == "Fisika"
                    ? Colors.green
                    : Colors.purple,
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassDetailScreen(classHistory: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
