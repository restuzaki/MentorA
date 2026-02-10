import 'package:flutter/material.dart';

class ProgressStudentScreen extends StatelessWidget {
  const ProgressStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Progress",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1: TOTAL & RATA-RATA ---
            Row(
              children: [
                _buildSummaryHeaderCard(
                  title: "Total Ulangan",
                  value: "48",
                  imageAsset: "assets/icons/book.png",
                  accentColor: Colors.orange,
                ),
                const SizedBox(width: 12),
                _buildSummaryHeaderCard(
                  title: "Rata-rata Nilai",
                  value: "82.5",
                  imageAsset: "assets/icons/target.png",
                  accentColor: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- SECTION 2: AKTIVITAS MINGGU INI ---
            _buildWeeklyActivityCard(),
            const SizedBox(height: 20),

            // --- SECTION 3: PROGRESS PER MAPEL ---
            const Text(
              "Progress per Mata Pelajaran",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildSubjectProgressCard(
              "Matematika",
              "15 ulangan",
              85,
              5.2,
              Colors.blue,
              "assets/icons/math.png",
            ),
            _buildSubjectProgressCard(
              "Bahasa Indonesia",
              "12 ulangan",
              78,
              3.1,
              Colors.green,
              "assets/icons/indo.png",
            ),
            _buildSubjectProgressCard(
              "IPA",
              "10 ulangan",
              82,
              0,
              Colors.purple,
              "assets/icons/ipa.png",
            ),
            _buildSubjectProgressCard(
              "IPS",
              "8 ulangan",
              75,
              -2.5,
              Colors.orange,
              "assets/icons/ips.png",
            ),
            _buildSubjectProgressCard(
              "Bahasa Inggris",
              "13 ulangan",
              88,
              7.8,
              Colors.pink,
              "assets/icons/inggris.png",
            ),

            const SizedBox(height: 20),

            // --- SECTION 4: PENCAPAIAN (SCROLL LANJUTAN) ---
            _buildAchievementGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper: Card Ringkasan Atas
  Widget _buildSummaryHeaderCard({
    required String title,
    required String value,
    required String imageAsset,
    required Color accentColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(bottom: BorderSide(color: accentColor, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(imageAsset, height: 24, width: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Card Aktivitas Mingguan
  Widget _buildWeeklyActivityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Aktivitas Minggu Ini",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Text(
                "5/7 hari ✓",
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDayBar("Sen", "3", true),
              _buildDayBar("Sel", "2", true),
              _buildDayBar("Rab", "4", true),
              _buildDayBar("Kam", "1", true),
              _buildDayBar("Jum", "2", true),
              _buildDayBar("Sab", "", false),
              _buildDayBar("Min", "", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayBar(String day, String count, bool active) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 35,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF10B981) : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  // Helper: Progress per Mapel
  Widget _buildSubjectProgressCard(
    String name,
    String count,
    int score,
    double trend,
    Color color,
    String asset,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(asset, height: 32, width: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      count,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$score",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${trend > 0 ? '↗' : '↘'} ${trend.abs()}%",
                    style: TextStyle(
                      color: trend >= 0 ? Colors.green : Colors.red,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: score / 100,
              backgroundColor: Colors.grey[100],
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Grid Pencapaian (Scroll Lanjutan)
  Widget _buildAchievementGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.emoji_events_outlined, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    "Pencapaian",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Text(
                "3/6",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
            children: [
              _buildAchievementItem(
                "Streak Master",
                "15 Jan 2026",
                "assets/icons/fire.png",
                true,
              ),
              _buildAchievementItem(
                "Perfect Score",
                "12 Jan 2026",
                "assets/icons/star.png",
                true,
              ),
              _buildAchievementItem(
                "Quiz Marathon",
                "",
                "assets/icons/trophy.png",
                false,
              ),
              _buildAchievementItem(
                "Speed Learner",
                "10 Jan 2026",
                "assets/icons/greent.png",
                true,
              ),
              _buildAchievementItem(
                "Early Bird",
                "",
                "assets/icons/jam.png",
                false,
              ),
              _buildAchievementItem(
                "All Rounder",
                "",
                "assets/icons/pin.png",
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(
    String title,
    String date,
    String asset,
    bool unlocked,
  ) {
    return Opacity(
      opacity: unlocked ? 1.0 : 0.4,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: unlocked ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, height: 40, width: 40),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
            if (date.isNotEmpty)
              Text(
                date,
                style: const TextStyle(fontSize: 8, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
