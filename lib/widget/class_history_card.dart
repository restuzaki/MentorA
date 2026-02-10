import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

class ClassHistoryCard extends StatelessWidget {
  final String className;
  final String subject;
  final int studentCount;
  final int averageScore;
  final String lastUpdate;
  final double percentageChange;
  final bool isIncrease;
  final Color color;

  const ClassHistoryCard({
    super.key,
    required this.className,
    required this.subject,
    required this.studentCount,
    required this.averageScore,
    required this.lastUpdate,
    required this.percentageChange,
    required this.isIncrease,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CustomColor.textBlack.withValues(alpha: 0.4))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(className, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                Row(
                  children: [
                    Icon(
                      isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isIncrease ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    Text("$percentageChange%", style: TextStyle(color: isIncrease ? Colors.green : Colors.red, fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(subject),
              backgroundColor: color.withValues(alpha: 0.2),
              labelStyle: TextStyle(color: color, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.people_outline, color: CustomColor.textBlack.withValues(alpha: 0.6), size: 20),
                const SizedBox(width: 8),
                Text("$studentCount Siswa", style: TextStyle(fontSize: 14, color: CustomColor.textBlack.withValues(alpha: 0.6))),
              ],
            ),
            const SizedBox(height: 8),
            Text("Rata-rata Nilai", style: TextStyle(fontSize: 14, color: color)),
            Text(averageScore.toString(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: CustomColor.textBlack.withOpacity(0.6), size: 16),
                const SizedBox(width: 8),
                Text("Update: $lastUpdate", style: TextStyle(fontSize: 12, color: CustomColor.textBlack.withOpacity(0.6))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
