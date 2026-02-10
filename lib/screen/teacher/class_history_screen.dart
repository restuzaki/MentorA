import 'package:flutter/material.dart';
import 'package:mentor_a/model/class_history_model.dart';
import 'package:mentor_a/screen/teacher/class_detail_screen.dart';
import 'package:mentor_a/style/custom_color.dart';

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
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassDetailScreen(classHistory: item),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: CustomColor.backgroundColor,
              shadowColor: CustomColor.primaryColor.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.className, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CustomColor.textBlack)),
                        Row(
                          children: [
                            Icon(
                              item.isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                              color: item.isIncrease ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            Text("${item.percentageChange}%", style: TextStyle(color: item.isIncrease ? Colors.green : Colors.red, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(item.subject),
                      backgroundColor: CustomColor.accentColor,
                      labelStyle: const TextStyle(color: CustomColor.textBlue, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.people_outline, color: CustomColor.textBlack.withValues(alpha: 0.6), size: 20),
                        const SizedBox(width: 8),
                        Text("${item.studentCount} Siswa", style: TextStyle(fontSize: 14, color: CustomColor.textBlack.withValues(alpha: 0.6))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("Rata-rata Nilai", style: TextStyle(fontSize: 14, color: CustomColor.textBlack.withValues(alpha: 0.6))),
                    Text(item.averageScore.toString(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: CustomColor.textBlack)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: CustomColor.textBlack.withValues(alpha: 0.6), size: 16),
                        const SizedBox(width: 8),
                        Text("Update: ${item.lastUpdate}", style: TextStyle(fontSize: 12, color: CustomColor.textBlack.withValues(alpha: 0.6))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
