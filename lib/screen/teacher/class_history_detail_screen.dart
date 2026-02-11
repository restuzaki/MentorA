import 'package:flutter/material.dart';
import 'package:mentor_a/model/class_history_model.dart';
import 'package:mentor_a/model/exam_result_model.dart';
import 'package:mentor_a/style/custom_color.dart';

class ClassDetailScreen extends StatelessWidget {
  final ClassHistoryModel classHistory;

  const ClassDetailScreen({super.key, required this.classHistory});

  @override
  Widget build(BuildContext context) {
    final List<ExamResultModel> examResults = [
      ExamResultModel(
          title: "Ulangan Harian Bab 3 - Geometri",
          date: "1 Jun 2025",
          participantCount: 30,
          averageScore: 86,
          scoreRange: "65-98"),
      ExamResultModel(
          title: "Ulangan Harian Bab 2 - Aljabar",
          date: "15 Mei 2025",
          participantCount: 32,
          averageScore: 82,
          scoreRange: "60-95"),
      ExamResultModel(
          title: "Ulangan Tengah Semester",
          date: "10 Mei 2025",
          participantCount: 32,
          averageScore: 87,
          scoreRange: "70-100"),
      ExamResultModel(
          title: "Ulangan Harian Bab 1 - Trigonometri",
          date: "1 Mei 2025",
          participantCount: 31,
          averageScore: 80,
          scoreRange: "58-92"),
      ExamResultModel(
          title: "Quiz Fungsi Kuadrat",
          date: "25 Apr 2025",
          participantCount: 32,
          averageScore: 78,
          scoreRange: "55-90"),
    ];

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          '${classHistory.className} - ${classHistory.subject}',
          style: const TextStyle(
              color: CustomColor.textBlack, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 24),
            Text(
              'Riwayat Ulangan (${examResults.length})',
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: CustomColor.textBlack),
            ),
            const SizedBox(height: 12),
            _buildExamHistoryList(examResults),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      color: CustomColor.backgroundColor,
      shadowColor: CustomColor.primaryColor.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem(Icons.people_outline, classHistory.studentCount.toString(), "Siswa", CustomColor.textBlue),
            _buildSummaryItem(Icons.leaderboard_outlined, "86", "Rata-rata", Colors.green),
            _buildSummaryItem(Icons.show_chart, "+${classHistory.percentageChange}%", "Perubahan", Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.textBlack)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: CustomColor.textBlack.withValues(alpha: 0.6))),
      ],
    );
  }

  Widget _buildExamHistoryList(List<ExamResultModel> examResults) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: examResults.length,
      itemBuilder: (context, index) {
        final item = examResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: CustomColor.backgroundColor,
          shadowColor: CustomColor.primaryColor.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.description_outlined, color: CustomColor.textBlue.withValues(alpha: 0.8), size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CustomColor.textBlack)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.calendar_today_outlined, color: CustomColor.textBlack.withValues(alpha: 0.6), size: 12),
                                const SizedBox(width: 4),
                                Text(item.date, style: TextStyle(fontSize: 12, color: CustomColor.textBlack.withValues(alpha: 0.6))),
                              ],
                            ),
                          ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Expanded(child: _buildExamStat("Peserta", item.participantCount.toString())),
                          Expanded(child: _buildExamStat("Rata-rata", item.averageScore.toString(), highlight: true)),
                          Expanded(child: _buildExamStat("Range", item.scoreRange)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExamStat(String label, String value, {bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: highlight ? CustomColor.accentColor.withValues(alpha: 0.5) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: highlight? CustomColor.textBlue : CustomColor.textBlack.withValues(alpha: 0.6))),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: highlight? CustomColor.textBlue :CustomColor.textBlack)),
        ],
      ),
    );
  }
}
