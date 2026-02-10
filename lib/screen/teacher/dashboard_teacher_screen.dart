import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mentor_a/model/class_history_model.dart';
import 'package:mentor_a/screen/notif_screen.dart';
import 'package:mentor_a/screen/teacher/class_detail_screen.dart';
import 'package:mentor_a/screen/teacher/class_history_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/class_history_card.dart';

class DashboardTeacherScreen extends StatelessWidget {
  const DashboardTeacherScreen({super.key});

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
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Dashboard Guru",
          style: TextStyle(color: CustomColor.textBlack, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Image.asset("assets/images/logo.png", height: 24, width: 24),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationStudentScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none, color: CustomColor.textBlack),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPerformanceChartCard(),
            const SizedBox(height: 20),
            _buildInsightCard(),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Riwayat Perkelas",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CustomColor.textBlack),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ClassHistoryScreen()));
                    },
                    child: const Text("Lihat Semua",
                        style: TextStyle(
                            color: CustomColor.textBlue, fontSize: 12)))
              ],
            ),
            const SizedBox(height: 12),
            _buildClassHistoryList(history),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceChartCard() {
    return Card(
      color: CustomColor.backgroundColor,
      shadowColor: CustomColor.primaryColor.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Grafik Performa Kelas",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CustomColor.textBlack,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 100,
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          if (value == 25 || value == 50 || value == 75) {
                            return Text(value.toInt().toString(), style: TextStyle(color: CustomColor.textBlack.withValues(alpha: 0.6), fontSize: 12));
                          }
                           if (value == 100) {
                            return Text("A+", style: TextStyle(color: CustomColor.textBlack.withValues(alpha: 0.6), fontSize: 12));
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun'];
                          if (value >= 0 && value < months.length) {
                            return SideTitleWidget(
                              meta: meta,
                              space: 8.0,
                              child: Text(
                                months[value.toInt()],
                                style: TextStyle(fontSize: 11, color: CustomColor.textBlack.withValues(alpha: 0.6)),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    _buildLineChartBarData(
                      [
                        const FlSpot(0, 75),
                        const FlSpot(1, 78),
                        const FlSpot(2, 80),
                        const FlSpot(3, 82),
                        const FlSpot(4, 85),
                        const FlSpot(5, 88),
                      ],
                      CustomColor.primaryColor,
                      isDashed: true,
                    ),
                    _buildLineChartBarData(
                      [
                        const FlSpot(0, 80),
                        const FlSpot(1, 82),
                        const FlSpot(2, 85),
                        const FlSpot(3, 84),
                        const FlSpot(4, 87),
                        const FlSpot(5, 90),
                      ],
                      CustomColor.textPurple,
                    ),
                    _buildLineChartBarData(
                      [
                        const FlSpot(0, 85),
                        const FlSpot(1, 84),
                        const FlSpot(2, 88),
                        const FlSpot(3, 86),
                        const FlSpot(4, 89),
                        const FlSpot(5, 92),
                      ],
                      CustomColor.accentColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildChartLegend(),
          ],
        ),
      ),
    );
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> spots, Color color, {bool isDashed = false}) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      dashArray: isDashed ? [5, 5] : null,
    );
  }

  Widget _buildChartLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _buildLegendItem(CustomColor.primaryColor, "B.Ind - 12A"),
        _buildLegendItem(CustomColor.accentColor, "Fisika - 11A"),
        _buildLegendItem(CustomColor.textPurple, "Mat - 10A"),
        _buildLegendItem(CustomColor.primaryColor, "Mat - 10B"),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_right_alt, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: CustomColor.textBlack.withValues(alpha: 0.6))),
      ],
    );
  }

  Widget _buildInsightCard() {
    return Card(
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
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [CustomColor.primaryColor, Color.fromRGBO(251, 191, 36, 1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset("assets/icons/stars.png",
                      height: 16, width: 16, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Insight Mingguan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.textBlack),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInsightItem(
              icon: const Icon(Icons.bar_chart, color: Colors.red),
              text:
                  "Nilai Matematika kelas 10A menurun 8% pada materi Pecahan. Disarankan ulangan remedial atau latihan tambahan.",
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              icon: const Icon(Icons.track_changes, color: Colors.blue),
              text:
                  "Kelas 11A menunjukkan peningkatan signifikan 12% pada Fisika. Pertahankan metode pengajaran saat ini.",
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text("Diperbarui otomatis setiap minggu",
                    style: TextStyle(
                        fontSize: 12,
                        color: CustomColor.textBlack.withValues(alpha: 0.6))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem({required Widget icon, required String text}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.centerLeft,
          end: AlignmentGeometry.centerRight,
          colors: [
            Color.fromRGBO(239, 246, 255, 1),
            Color.fromRGBO(250, 245, 255, 1),
          ]
        ),
        border: Border.all(color: CustomColor.primaryColor.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 13, color: CustomColor.textBlack, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassHistoryList(List<ClassHistoryModel> history) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return ClassHistoryCard(
          className: item.className,
          subject: item.subject,
          studentCount: item.studentCount,
          averageScore: item.averageScore,
          lastUpdate: item.lastUpdate,
          percentageChange: item.percentageChange,
          isIncrease: item.isIncrease,
          color: CustomColor.primaryColor,
        );
      },
    );
  }
}
