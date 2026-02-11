import 'package:flutter/material.dart';
import 'package:mentor_a/screen/teacher/dashboard_teacher_screen.dart';
import 'package:mentor_a/screen/teacher/exam_teacher_screen.dart';
import 'package:mentor_a/screen/teacher/subject_teacher_screen.dart';
import 'package:mentor_a/widget/teacher_bottom_nav.dart';

import '../profile_screen.dart';

class HomeTeacherScreen extends StatefulWidget {
  const HomeTeacherScreen({super.key});

  @override
  State<HomeTeacherScreen> createState() => _HomeTeacherScreenState();
}

class _HomeTeacherScreenState extends State<HomeTeacherScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DashboardTeacherScreen(),
    const SubjectTeacherScreen(),
    const ExamTeacherScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomButtonNavTeacher(
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
