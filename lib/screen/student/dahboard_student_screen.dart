import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mentor_a/screen/student/history_student_screen.dart';
import 'package:mentor_a/screen/student/notif_student_screen.dart';
import 'package:mentor_a/screen/student/progress_student_screen.dart';
import 'package:mentor_a/style/custom_color.dart';

class DahboardStudentScreen extends StatelessWidget {
  const DahboardStudentScreen({super.key});

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
          "Dashboard Murid",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: CustomColor.backgroundColor,
              shadowColor: Colors.grey.withValues(alpha: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSectionHeader(
                      title: "Performa Belajar",
                      hasPercentage: true,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: LineChart(
                        LineChartData(
                          minX: -0.5,
                          maxX: 5.5,
                          minY: 0,
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    'Jan',
                                    'Feb',
                                    'Mar',
                                    'Apr',
                                    'Mei',
                                    'Jun',
                                  ];
                                  if (value >= 0 &&
                                      value < months.length &&
                                      value % 1 == 0) {
                                    return SideTitleWidget(
                                      meta: meta,
                                      space: 8.0,
                                      child: Text(
                                        months[value.toInt()],
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
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
                            LineChartBarData(
                              spots: [
                                const FlSpot(0, 2),
                                const FlSpot(1, 2.8),
                                const FlSpot(2, 3.2),
                                const FlSpot(3, 3.8),
                                const FlSpot(4, 4.2),
                                const FlSpot(5, 4.8),
                              ],
                              isCurved: false,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter:
                                    (spot, percent, barData, index) =>
                                        FlDotCirclePainter(
                                          radius: 4,
                                          color: CustomColor.primaryColor,
                                          strokeWidth: 0,
                                        ),
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    CustomColor.primaryColor.withValues(
                                      alpha: 0.30,
                                    ),
                                    CustomColor.backgroundColor.withValues(
                                      alpha: 0.6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.9),
                            CustomColor.textPurple.withValues(alpha: 0.3),
                            CustomColor.textBlue.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0.9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: CustomColor.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              "assets/icons/stars.png",
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AI Insight",
                                  style: TextStyle(
                                    color: CustomColor.textPurple,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Performamu meningkat 5% minggu ini! Pertahankan konsistensi belajarmu, terutama di Matematika. 🎉",
                                  style: TextStyle(
                                    color: CustomColor.textPurple,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProgressStudentScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(
                  20,
                ), // Padding sedikit diperbesar agar lega
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            "assets/images/pp_intan.png",
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Halo, Intan!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Level 12 • 2450 XP",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            "assets/icons/stars.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress ke Level 13",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "2450/3000 XP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 2450 / 3000,
                              minHeight: 8,
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.2,
                              ),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // --- SECTION STATS (Level, Matematika, Hari) ---
            const SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard(
                  label: "Level 12",
                  imageAsset: "assets/icons/achivement.png",
                  bgColor: const Color(0xFFFFF9E6),
                  iconBgColor: const Color(0xFFFFECB3),
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  label: "Matematika",
                  imageAsset: "assets/icons/target.png",
                  bgColor: const Color(0xFFE3F2FD),
                  iconBgColor: const Color(0xFFBBDEFB),
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  label: "Hari 181",
                  imageAsset: "assets/icons/fire.png",
                  bgColor: const Color(0xFFFFF3E0),
                  iconBgColor: const Color(0xFFFFE0B2),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- SECTION MISI HARIAN ---
            Row(
              children: [
                Image.asset("assets/icons/thunder.png", height: 20, width: 20),
                const SizedBox(width: 8),
                const Text(
                  "Misi Harian",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
              ],
            ),
            _buildMisiItem("Selesaikan 5 Soal Matematika", "3/5 > +40 XP", 0.6),
            _buildMisiItem("Belajar 30 Menit Hari Ini", "15/30 > +30 XP", 0.5),
            const SizedBox(height: 20),

            // --- SECTION RIWAYAT ULANGAN ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Riwayat Ulangan",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryStudentScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Lihat Semua >",
                    style: TextStyle(
                      fontSize: 12,
                      color: CustomColor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            _buildRiwayatItem(
              "Matematika",
              "Ulangan Harian Bab 3",
              "88",
              "+6%",
            ),
            _buildRiwayatItem(
              "Fisika",
              "Ulangan Harian Bab 2",
              "85",
              "-5%",
              isDown: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required bool hasPercentage,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          if (hasPercentage)
            Row(
              children: [
                const Icon(Icons.trending_up, color: Colors.green, size: 16),
                SizedBox(width: 4),
                const Text(
                  "+5%",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMisiItem(String title, String progress, double val) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      color: CustomColor.backgroundColor,
      shadowColor: Colors.grey.withValues(alpha: 1.5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.normal)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: val,
              color: CustomColor.primaryColor,
              backgroundColor: Colors.grey.withValues(alpha: 0.3),
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 4),
            Text(
              progress,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiwayatItem(
    String sub,
    String desc,
    String score,
    String pct, {
    bool isDown = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: CustomColor.backgroundColor,
      child: ListTile(
        title: Text(sub, style: const TextStyle(fontWeight: FontWeight.normal)),
        subtitle: Text(desc),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              score,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.blue,
              ),
            ),
            Text(
              pct,
              style: TextStyle(
                color: isDown ? Colors.red : Colors.green,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String imageAsset,
    required Color bgColor,
    required Color iconBgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(imageAsset, height: 28, width: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF455A64),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
