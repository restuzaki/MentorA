import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

class NotificationStudentScreen extends StatelessWidget {
  const NotificationStudentScreen({super.key});

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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withValues(alpha: 0.1),
            height: 1.0,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationCard(
            title: "Nilai Ulangan Sudah Keluar",
            description:
                "Nilai Ulangan Harian Bab 3 - Geometri sudah tersedia. Kamu mendapat nilai 88! Bagus sekali! 🎉",
            time: "30 menit lalu",
            category: "Matematika",
            icon: Icons.check,
            iconBgColor: const Color(0xFFDCFCE7),
            iconColor: const Color(0xFF22C55E),
            isUnread: true,
            hasButtons: true,
            primaryButtonText: "Lihat Nilai",
          ),
          _buildNotificationCard(
            title: "Deadline Ulangan Mendekati",
            description:
                "Ulangan Harian Bab 2 - Aljabar akan berakhir dalam 2 hari. Jangan lupa dikerjakan ya!",
            time: "1 jam lalu",
            category: "Matematika",
            icon: Icons.access_time,
            iconBgColor: const Color(0xFFFEF9C3),
            iconColor: const Color(0xFFEAB308),
            isUnread: true,
          ),
          _buildNotificationCard(
            title: "Achievement Unlocked! 🏆",
            description:
                "Selamat! Kamu naik ke Level 12 dan mendapat badge \"Konsisten Belajar 7 Hari\". Pertahankan!",
            time: "2 jam lalu",
            icon: Icons.emoji_events_outlined,
            iconBgColor: const Color(0xFFFFF7ED),
            iconColor: const Color(0xFFF97316),
            isUnread: true,
            hasButtons: true,
            primaryButtonText: "Lihat Badge",
          ),
          _buildNotificationCard(
            title: "Misi Harian Baru Tersedia",
            description:
                "Misi harian: Selesaikan 5 soal Matematika dan dapatkan +50 XP. Yuk kerjakan sekarang!",
            time: "5 jam lalu",
            icon: Icons.track_changes,
            iconBgColor: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF3B82F6),
            isUnread: false,
          ),
          _buildNotificationCard(
            title: "Ulangan Baru Tersedia",
            description:
                "Guru telah membuat ulangan baru: Ulangan Harian Bab 4 - Trigonometri. Deadline: 3 hari lagi.",
            time: "1 hari lalu",
            category: "Matematika",
            icon: Icons.menu_book_rounded,
            iconBgColor: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF3B82F6),
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
    String? category,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    bool isUnread = false,
    bool hasButtons = false,
    String? primaryButtonText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),

        boxShadow: [
          if (isUnread)
            const BoxShadow(
              color: Color(0xFF3B82F6),
              spreadRadius: -12,
              offset: Offset(-14, 0),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ikon Notifikasi
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                // Konten Teks
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          if (isUnread)
                            const CircleAvatar(
                              radius: 4,
                              backgroundColor: Color(0xFF3B82F6),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (category != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (hasButtons) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(primaryButtonText ?? "Lihat"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.1),
                        ),
                        backgroundColor: const Color(0xFFF1F5F9),
                        foregroundColor: const Color(0xFF64748B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("Tandai Dibaca"),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
