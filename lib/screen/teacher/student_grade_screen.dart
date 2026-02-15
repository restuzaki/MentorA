import 'package:flutter/material.dart';
import 'package:mentor_a/model/student_grade_model.dart';
import 'package:mentor_a/screen/teacher/detailed_answer_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/grade_summary_card.dart';
import 'package:mentor_a/widget/student_grade_card.dart';
import 'package:mentor_a/widget/subject_search_bar.dart';

/// Screen displaying student grades for a specific exam
class StudentGradeScreen extends StatefulWidget {
  final String examTitle;
  final String examId;
  final String? subjectName;
  final String? className;

  const StudentGradeScreen({
    super.key,
    required this.examTitle,
    required this.examId,
    this.subjectName,
    this.className,
  });

  @override
  State<StudentGradeScreen> createState() => _StudentGradeScreenState();
}

class _StudentGradeScreenState extends State<StudentGradeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<StudentGrade> _grades = [];
  List<StudentGrade> _filteredGrades = [];
  late GradeSummary _summary;

  @override
  void initState() {
    super.initState();
    _loadGrades();
    _searchController.addListener(_filterGrades);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadGrades() {
    // Sample data - in real app, this would come from a database
    _grades = [
      StudentGrade(
        id: '1',
        studentName: 'Ahmad Rizki',
        score: 86,
        submissionTime: DateTime(2026, 1, 20, 10, 30),
        status: SubmissionStatus.submitted,
      ),
      StudentGrade(
        id: '2',
        studentName: 'Siti Nurhaliza',
        score: 92,
        submissionTime: DateTime(2026, 1, 20, 10, 25),
        status: SubmissionStatus.submitted,
      ),
      StudentGrade(
        id: '3',
        studentName: 'Budi Santoso',
        score: 78,
        submissionTime: DateTime(2026, 1, 20, 10, 45),
        status: SubmissionStatus.submitted,
      ),
      StudentGrade(
        id: '4',
        studentName: 'Rina Wati',
        score: null,
        submissionTime: null,
        status: SubmissionStatus.notSubmitted,
      ),
      StudentGrade(
        id: '5',
        studentName: 'Andi Wijaya',
        score: 88,
        submissionTime: DateTime(2026, 1, 20, 10, 35),
        status: SubmissionStatus.submitted,
      ),
    ];
    _filteredGrades = _grades;
    _summary = GradeSummary.fromGrades(_grades);
  }

  void _filterGrades() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredGrades = _grades;
      } else {
        _filteredGrades = _grades
            .where((grade) => grade.studentName.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _viewStudentDetail(StudentGrade grade) {
    // Navigate to detailed answer view
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedAnswerScreen(
          studentName: grade.studentName,
          examTitle: widget.examTitle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Nilai Murid',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomColor.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SubjectSearchBar(
              searchController: _searchController,
              hintText: 'Cari nama murid...',
              onAddPressed: () {
                // Could add functionality to add new student grade manually
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tambah nilai manual (coming soon)'),
                    backgroundColor: CustomColor.primaryColor,
                  ),
                );
              },
            ),
          ),
          // Summary card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GradeSummaryCard(summary: _summary),
          ),
          const SizedBox(height: 20),
          // Grade list header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar Nilai (${_grades.length})',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textBlack,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Grade list or empty state
          Expanded(
            child: _grades.isEmpty ? _buildEmptyState() : _buildGradeList(),
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
              Icons.assignment_outlined,
              color: CustomColor.primaryColor,
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Belum ada nilai untuk ulangan ini',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: CustomColor.textGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredGrades.length,
      itemBuilder: (context, index) {
        final grade = _filteredGrades[index];
        return StudentGradeCard(
          grade: grade,
          onViewDetail: () => _viewStudentDetail(grade),
        );
      },
    );
  }
}
