import 'package:flutter/material.dart';
import 'package:mentor_a/screen/student/chatbot_student_screen.dart';
import 'package:mentor_a/screen/student/dahboard_student_screen.dart';
import 'package:mentor_a/screen/student/exam_student_screen.dart';
import 'package:mentor_a/screen/student/subject_student_screen.dart';
import '../../widget/student_bottom_nav.dart';

class HomeStudentScreen extends StatefulWidget {
  const HomeStudentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeStudentScreenState createState() => _HomeStudentScreenState();
}

class _HomeStudentScreenState extends State<HomeStudentScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DahboardStudentScreen(),
    const SubjectStudentScreen(),
    const ExamStudentScreen(),
    ChatbotStudentScreen(),
    const Center(child: Text('Halaman Profil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: CustomBottomNavStudent(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
