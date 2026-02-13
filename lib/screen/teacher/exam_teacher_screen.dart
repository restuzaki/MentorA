import 'package:flutter/material.dart';
import 'package:mentor_a/screen/teacher/exam_list_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/subject_card.dart';

/// Main screen showing list of subjects/classes for exams (Screen 1)
class ExamTeacherScreen extends StatefulWidget {
  const ExamTeacherScreen({super.key});

  @override
  State<ExamTeacherScreen> createState() => _ExamTeacherScreenState();
}

class _ExamTeacherScreenState extends State<ExamTeacherScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _subjects = [];
  List<Map<String, String>> _filteredSubjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
    _searchController.addListener(_filterSubjects);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadSubjects() {
    // Sample data - in real app, this would come from a database
    _subjects = [
      {'name': 'Matematika', 'class': 'Kelas 10A'},
      {'name': 'Matematika', 'class': 'Kelas 10B'},
      {'name': 'Fisika', 'class': 'Kelas 11A'},
      {'name': 'Bahasa Indonesia', 'class': 'Kelas 12A'},
    ];
    _filteredSubjects = _subjects;
  }

  void _filterSubjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSubjects = _subjects;
      } else {
        _filteredSubjects = _subjects.where((subject) {
          final name = subject['name']!.toLowerCase();
          final className = subject['class']!.toLowerCase();
          return name.contains(query) || className.contains(query);
        }).toList();
      }
    });
  }

  void _navigateToExamList(String subjectName, String className) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExamListScreen(subjectName: subjectName, className: className),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Ulangan Harian',
          style: TextStyle(
            color: CustomColor.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0.5,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Cari mata pelajaran atau kelas...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: CustomColor.hintGrey,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: CustomColor.textGrey,
                  size: 20,
                ),
                filled: true,
                fillColor: CustomColor.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: CustomColor.primaryColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                isDense: true,
              ),
            ),
          ),
          // Subject list
          Expanded(
            child: _filteredSubjects.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredSubjects.length,
                    itemBuilder: (context, index) {
                      final subject = _filteredSubjects[index];
                      return SubjectCard(
                        title: subject['name']!,
                        subtitle: subject['class']!,
                        onTap: () => _navigateToExamList(
                          subject['name']!,
                          subject['class']!,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CustomColor.lightAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.search_off,
              color: CustomColor.primaryColor,
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Tidak ada mata pelajaran yang ditemukan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: CustomColor.textGrey),
            ),
          ),
        ],
      ),
    );
  }
}
