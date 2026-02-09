import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

class HistoryStudentScreen extends StatelessWidget {
  const HistoryStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
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
          "Riwayat Ulangan",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- BAGIAN STATISTIK ATAS ---
          Row(
            children: [
              _buildSummaryCard(
                "86",
                "Rata-rata",
                Icons.bar_chart,
                const Color(0xFFEFF6FF),
                Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildSummaryCard(
                "92",
                "Tertinggi",
                Icons.emoji_events_outlined,
                const Color(0xFFFFFBEB),
                Colors.orange,
              ),
              const SizedBox(width: 12),
              _buildSummaryCard(
                "8",
                "Meningkat",
                Icons.trending_up,
                const Color(0xFFF0FDF4),
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- DAFTAR RIWAYAT ---
          _buildResultCard(
            subject: "Matematika",
            type: "Harian",
            title: "Ulangan Harian Bab 3 - Geometri",
            date: "1 Jun 2025",
            score: "88",
            trend: "+6",
            baseScore: "82",
            isUp: true,
          ),
          _buildResultCard(
            subject: "Fisika",
            type: "Harian",
            title: "Ulangan Harian Bab 2 - Gerak Lurus",
            date: "30 Mei 2025",
            score: "85",
            trend: "-5",
            baseScore: "90",
            isUp: false,
          ),
          _buildResultCard(
            subject: "Bahasa Indonesia",
            type: "UTS",
            title: "Ulangan Tengah Semester",
            date: "28 Mei 2025",
            score: "92",
            trend: "+4",
            baseScore: "88",
            isUp: true,
            typeColor: const Color(0xFFFEF3C7),
            typeTextColor: const Color(0xFFD97706),
          ),
          _buildResultCard(
            subject: "Matematika",
            type: "Harian",
            title: "Ulangan Harian Bab 2 - Aljabar",
            date: "25 Mei 2025",
            score: "82",
            trend: "-3",
            baseScore: "85",
            isUp: false,
          ),
          _buildResultCard(
            subject: "Kimia",
            type: "Harian",
            title: "Ulangan Harian Bab 1 - Struktur Atom",
            date: "20 Mei 2025",
            score: "78",
            trend: "+3",
            baseScore: "75",
            isUnread: true,
            isUp: true,
          ),
          _buildResultCard(
            subject: "Matematika",
            type: "UAS",
            title: "Ulangan Akhir Semester",
            date: "1 Mei 2025",
            score: "90",
            trend: "+2",
            baseScore: "88",
            isUp: true,
            typeColor: const Color(0xFFFCE7F3),
            typeTextColor: const Color(0xFFDB2777),
          ),
        ],
      ),
    );
  }

  // Widget untuk 3 kotak di bagian atas
  Widget _buildSummaryCard(
    String value,
    String label,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Color(0xFF1E293B),
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk kartu riwayat nilai
  Widget _buildResultCard({
    required String subject,
    required String type,
    required String title,
    required String date,
    required String score,
    required String trend,
    required String baseScore,
    required bool isUp,
    bool isUnread = false,
    Color? typeColor,
    Color? typeTextColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: typeColor ?? const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: typeTextColor ?? const Color(0xFF2563EB),
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                score,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF3B82F6),
                ),
              ),
              Row(
                children: [
                  Icon(
                    isUp ? Icons.trending_up : Icons.trending_down,
                    size: 14,
                    color: isUp ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    trend,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isUp ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              Text(
                "dari $baseScore",
                style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
