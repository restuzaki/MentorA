import 'package:flutter/material.dart';
import 'package:mentor_a/model/subject_model.dart';
import 'package:mentor_a/screen/teacher/add_subject_teacher_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/subject_card.dart';
import 'package:mentor_a/widget/subject_search_bar.dart';

class SubjectTeacherScreen extends StatefulWidget {
  const SubjectTeacherScreen({super.key});

  @override
  State<SubjectTeacherScreen> createState() => _SubjectTeacherScreenState();
}

class _SubjectTeacherScreenState extends State<SubjectTeacherScreen> {
  final List<Subject> subjects = [
    Subject("Matematika", "Kelas 10A", []),
    Subject("Fisika", "Kelas 11A", []),
    Subject("Bahasa Indonesia", "Kelas 12A", []),
  ];

  void _navigateToAddSubject() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddSubjectTeacherScreen()),
    );
  }

  void _deleteSubject(int index) {
    setState(() {
      subjects.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text("Mata pelajaran berhasil dihapus"),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Mata Pelajaran",
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
            SubjectSearchBar(onAddPressed: _navigateToAddSubject),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return SubjectCard(
                    title: subjects[index].name,
                    subtitle: subjects[index].grade,
                    trailing: TextButton(
                      onPressed: () => _deleteSubject(index),
                      child: const Text(
                        "Hapus",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
