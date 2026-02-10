import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mentor_a/screen/notif_screen.dart';
import 'package:mentor_a/screen/teacher/class_history_screen.dart';
import 'package:mentor_a/style/custom_color.dart';

class DashboardTeacherScreen extends StatelessWidget {
  const DashboardTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            _buildClassHistoryHeader(context),
            const SizedBox(height: 12),
            _buildClassHistoryCard(),
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


  Widget _buildClassHistoryHeader(BuildContext context) {
    return Row(
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
              MaterialPageRoute(builder: (context) => const ClassHistoryScreen()),
            );
          },
          child: const Text(
            "Lihat Semua >",
            style: TextStyle(fontSize: 14, color: CustomColor.primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildClassHistoryCard() {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Kelas 10A", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CustomColor.textBlack)),
                Row(
                  children: const [
                    Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                    Text("5%", style: TextStyle(color: Colors.green, fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Chip(
              label: const Text("Matematika"),
              backgroundColor: CustomColor.accentColor,
              labelStyle: const TextStyle(color: CustomColor.textBlue, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.people_outline, color: CustomColor.textBlack.withValues(alpha: 0.6), size: 20),
                const SizedBox(width: 8),
                Text("32 Siswa", style: TextStyle(fontSize: 14, color: CustomColor.textBlack.withValues(alpha: 0.6))),
              ],
            ),
            const SizedBox(height: 8),
            Text("Rata-rata Nilai", style: TextStyle(fontSize: 14, color: CustomColor.textBlack.withValues(alpha: 0.6))),
            const Text("85", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: CustomColor.textBlack)),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: CustomColor.textBlack.withValues(alpha: 0.6), size: 16),
                const SizedBox(width: 8),
                Text("Update: 5 Jun 2025", style: TextStyle(fontSize: 12, color: CustomColor.textBlack.withValues(alpha: 0.6))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
