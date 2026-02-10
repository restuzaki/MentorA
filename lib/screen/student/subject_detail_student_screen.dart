import 'package:flutter/material.dart';
import 'package:mentor_a/screen/student/quiz_student_screen.dart';
import 'package:mentor_a/screen/student/sumarry_subject_student_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/subject_model.dart';

class SubjectDetailStudentScreen extends StatelessWidget {
  final Subject subject;

  const SubjectDetailStudentScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${subject.name} - ${subject.grade}",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0.5,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card: Nama Mata Pelajaran & Kelas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabelledField("Nama Mata Pelajaran", subject.name),
                  const SizedBox(height: 16),
                  _buildLabelledField("Kelas", subject.grade),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Materi / Sub Bab",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            // List Bab secara dinamis
            ...subject.chapters.map(
              (chapter) => _buildChapterCard(context, chapter),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelledField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildChapterCard(BuildContext context, Chapter chapter) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  chapter.chapterNumber,
                  style: const TextStyle(color: Colors.blue, fontSize: 10),
                ),
              ),
              if (chapter.status.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    chapter.status,
                    style: const TextStyle(color: Colors.orange, fontSize: 10),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            chapter.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // List Item Materi (PDF, Video, Link)
          ...chapter.items.map((item) => _buildMaterialTile(item)),
          const SizedBox(height: 8),
          _buildExtraField(
            context,
            "Rangkuman",
            chapter.title,
            chapter,
            chapter.summary,
          ),
          const SizedBox(height: 12),
          _buildExtraField(
            context,
            "Kumpulan Soal",
            chapter.title,
            chapter,
            chapter.summary,
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialTile(MaterialItem item) {
    return InkWell(
      onTap: () {
        if (item.subtitle.startsWith('http')) {
          _launchURL(item.subtitle);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          // Hanya tampilkan leading jika icon ada
          leading: item.icon != null
              ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.iconColor ?? CustomColor.primaryColor,
                    size: 20,
                  ),
                )
              : null, // Jika null, ListTile otomatis menggeser teks ke kiri
          title: Text(
            item.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            item.subtitle,
            style: TextStyle(
              fontSize: 11,
              color: item.subtitle.startsWith('http')
                  ? Colors.blue
                  : Colors.blueGrey,
              decoration: item.subtitle.startsWith('http')
                  ? TextDecoration.none
                  : TextDecoration.none,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildExtraField(
    BuildContext context,
    String label,
    String value,
    Chapter chapter,
    String? summary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),

        GestureDetector(
          onTap: () {
            if (label == "Rangkuman") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SummaryScreen(title: value, summaryText: chapter.summary),
                ),
              );
            } else if (label == "Kumpulan Soal") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizStudentScreen(
                    chapterTitle: chapter.title,
                    quizzes: chapter.quizzes,
                  ),
                ),
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(value, style: const TextStyle(fontSize: 14)),
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $urlString';
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }
}
