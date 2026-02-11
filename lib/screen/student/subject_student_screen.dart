import "package:flutter/material.dart";
import "package:mentor_a/screen/student/subject_detail_student_screen.dart";
import "package:mentor_a/style/custom_color.dart";
import "package:mentor_a/widget/custom_action_button.dart";
import "package:mentor_a/widget/subject_card.dart";
import "package:mentor_a/widget/subject_search_bar.dart";

import "../../model/subject_model.dart";

class SubjectStudentScreen extends StatefulWidget {
  const SubjectStudentScreen({super.key});

  @override
  State<SubjectStudentScreen> createState() => _SubjectStudentScreenState();
}

class _SubjectStudentScreenState extends State<SubjectStudentScreen> {
  final List<Subject> subjects = [
    // 1. MATEMATIKA
    Subject("Matematika", "Kelas 10A", [
      Chapter(
        chapterNumber: "Bab 1",
        title: "Persamaan Linear 1",
        status: "Perlu ditingkatkan",
        summary:
            "Sistem persamaan linear adalah sekumpulan persamaan yang memiliki variabel yang sama. Bentuk umum persamaan linear satu variabel adalah ax + b = 0. Materi ini mencakup metode substitusi dan eliminasi untuk mencari nilai variabel.",
        quizzes: [
          Quiz(
            title: "Quiz 1 - Persamaan Linear 1",
            date: "01/03/2026",
            questionCount: 3,
            questions: [],
          ),
          Quiz(
            title: "Quiz 2 - Persamaan Linear 1",
            date: "05/03/2026",
            questionCount: 5,
            questions: [],
          ),
        ],
        items: [
          MaterialItem(
            title: "PL.pdf",
            subtitle: "2105.8 kB",
            icon: Icons.description,
            iconColor: Colors.green,
          ),
          MaterialItem(
            title: "Persamaan__linear.mp4",
            subtitle: "43022.8 kB",
            icon: Icons.videocam,
            iconColor: Colors.blue,
          ),
          MaterialItem(
            title: "Video Pecahan",
            subtitle: "https://www.youtube.com/watch?v=LJqd",
            icon: Icons.link,
            iconColor: Colors.orange,
          ),
        ],
      ),
      Chapter(
        chapterNumber: "Bab 2",
        title: "Persamaan Kuadrat",
        quizzes: [
          Quiz(
            title: "Quiz 1 - Persamaan Linear 1",
            date: "01/03/2026",
            questionCount: 3,
            questions: [],
          ),
          Quiz(
            title: "Quiz 2 - Persamaan Linear 1",
            date: "05/03/2026",
            questionCount: 5,
            questions: [],
          ),
        ],
        summary:
            "Sistem persamaan linear adalah sekumpulan persamaan yang memiliki variabel yang sama. Bentuk umum persamaan linear satu variabel adalah ax + b = 0. Materi ini mencakup metode substitusi dan eliminasi untuk mencari nilai variabel.",
        items: [
          MaterialItem(
            title: "PK.pdf",
            subtitle: "1890.2 kB",
            icon: Icons.description,
            iconColor: Colors.green,
          ),
        ],
      ),
    ]),

    // 2. BAHASA INDONESIA
    Subject("Bahasa Indonesia", "Kelas 10A", [
      Chapter(
        chapterNumber: "Bab 1",
        title: "Teks Laporan Hasil Observasi",
        summary:
            "Persamaan kuadrat adalah persamaan dengan pangkat tertinggi dua. Bentuk umumnya ax² + bx + c = 0. Akar-akar persamaan dapat dicari menggunakan rumus ABC, pemfaktoran, atau melengkapkan kuadrat sempurna.",
        quizzes: [
          Quiz(
            title: "Quiz 1 - Persamaan Linear 1",
            date: "01/03/2026",
            questionCount: 3,
            questions: [],
          ),
          Quiz(
            title: "Quiz 2 - Persamaan Linear 1",
            date: "05/03/2026",
            questionCount: 5,
            questions: [],
          ),
        ],
        items: [
          MaterialItem(
            title: "Materi_LHO.pdf",
            subtitle: "1200.5 kB",
            icon: Icons.description,
            iconColor: Colors.green,
          ),
          MaterialItem(
            title: "Contoh Video LHO",
            subtitle: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            icon: Icons.link,
            iconColor: Colors.red,
          ),
        ],
      ),
    ]),

    // 3. FISIKA
    Subject("Fisika", "Kelas 10A", [
      Chapter(
        chapterNumber: "Bab 1",
        title: "Besaran dan Satuan",
        summary:
            "Sistem persamaan linear adalah sekumpulan persamaan yang memiliki variabel yang sama. Bentuk umum persamaan linear satu variabel adalah ax + b = 0. Materi ini mencakup metode substitusi dan eliminasi untuk mencari nilai variabel.",
        quizzes: [
          Quiz(
            title: "Quiz 1 - Persamaan Linear 1",
            date: "01/03/2026",
            questionCount: 3,
            questions: [],
          ),
          Quiz(
            title: "Quiz 2 - Persamaan Linear 1",
            date: "05/03/2026",
            questionCount: 5,
            questions: [],
          ),
        ],
        items: [
          MaterialItem(
            title: "Modul_Fisika.pdf",
            subtitle: "950.0 kB",
            icon: Icons.description,
            iconColor: Colors.green,
          ),
          MaterialItem(
            title: "Video Praktikum",
            subtitle: "https://www.youtube.com/watch?v=Xn87-y7T97I",
            icon: Icons.videocam,
            iconColor: Colors.blue,
          ),
        ],
      ),
    ]),

    // 4. BAHASA INGGRIS
    Subject("Bahasa Inggris", "Kelas 10A", [
      Chapter(
        chapterNumber: "Bab 1",
        title: "Talking about Self",
        summary:
            "Sistem persamaan linear adalah sekumpulan persamaan yang memiliki variabel yang sama. Bentuk umum persamaan linear satu variabel adalah ax + b = 0. Materi ini mencakup metode substitusi dan eliminasi untuk mencari nilai variabel.",
        quizzes: [
          Quiz(
            title: "Quiz 1 - Persamaan Linear 1",
            date: "01/03/2026",
            questionCount: 3,
            questions: [],
          ),
          Quiz(
            title: "Quiz 2 - Persamaan Linear 1",
            date: "05/03/2026",
            questionCount: 5,
            questions: [],
          ),
        ],
        items: [
          MaterialItem(
            title: "Introduction.pdf",
            subtitle: "800.2 kB",
            icon: Icons.description,
            iconColor: Colors.green,
          ),
          MaterialItem(
            title: "Listening Task",
            subtitle: "https://www.youtube.com/watch?v=...",
            icon: Icons.link,
            iconColor: Colors.orange,
          ),
        ],
      ),
    ]),
  ];

  void _showAddClassDialog() {
    showDialog(
      context: context,
      builder: (context) => CustomActionDialog(
        title: "Kelas",
        subtitle: "Masukkan kode kelas",
        hintText: "Adv2345j",
        onSave: (value) {
          // Tambahkan logika untuk update UI atau kirim ke API di sini
          setState(() {
            subjects.add(Subject("Kelas Baru", "Kelas X", []));
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Belajar",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0.5,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SubjectSearchBar(onAddPressed: _showAddClassDialog),
            const SizedBox(height: 20),
            // List Mata Pelajaran
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return SubjectCard(
                    title: subjects[index].name,
                    subtitle: subjects[index].grade,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubjectDetailStudentScreen(
                            subject: subjects[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
