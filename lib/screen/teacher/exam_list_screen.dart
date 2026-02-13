import 'package:flutter/material.dart';
import 'package:mentor_a/model/subject_model.dart';
import 'package:mentor_a/screen/teacher/create_exam_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/delete_confirmation_dialog.dart';
import 'package:mentor_a/widget/exam_card.dart';
import 'package:mentor_a/widget/exam_count_badge.dart';
import 'package:mentor_a/widget/subject_search_bar.dart';

/// Screen showing list of exams for a specific subject (Screen 2)
class ExamListScreen extends StatefulWidget {
  final String subjectName;
  final String className;

  const ExamListScreen({
    super.key,
    required this.subjectName,
    required this.className,
  });

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Exam> _exams = [];
  List<Exam> _filteredExams = [];

  @override
  void initState() {
    super.initState();
    _loadExams();
    _searchController.addListener(_filterExams);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadExams() {
    // Sample data - in real app, this would come from a database
    _exams = [
      Exam(
        id: '1',
        title: 'Ulangan Harian Bab 1 - Aljabar',
        date: DateTime(2026, 1, 20),
        duration: 90,
        questionCount: 25,
        subjectName: widget.subjectName,
        className: widget.className,
        questions: [],
      ),
      Exam(
        id: '2',
        title: 'Ulangan Harian Bab 2 - Geometri',
        date: DateTime(2026, 2, 1),
        duration: 90,
        questionCount: 30,
        subjectName: widget.subjectName,
        className: widget.className,
        questions: [],
      ),
    ];
    _filteredExams = _exams;
  }

  void _filterExams() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredExams = _exams;
      } else {
        _filteredExams = _exams
            .where((exam) => exam.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _navigateToCreateExam({Exam? examToEdit}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateExamScreen(
          subjectName: widget.subjectName,
          className: widget.className,
          examToEdit: examToEdit,
        ),
      ),
    );

    if (result != null && result is Exam) {
      setState(() {
        if (examToEdit != null) {
          // Update existing exam
          final index = _exams.indexWhere((e) => e.id == examToEdit.id);
          if (index != -1) {
            _exams[index] = result;
          }
        } else {
          // Add new exam
          _exams.add(result);
        }
        _filterExams();
      });
    }
  }

  void _deleteExam(Exam exam) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: 'Hapus Ulangan',
        itemName: exam.title,
        onConfirm: () {
          setState(() {
            _exams.removeWhere((e) => e.id == exam.id);
            _filterExams();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ulangan "${exam.title}" berhasil dihapus'),
              backgroundColor: CustomColor.errorRed,
            ),
          );
        },
      ),
    );
  }

  void _showExamDetail(Exam exam) {
    // Navigate to exam detail screen (to be implemented)
    _navigateToCreateExam(examToEdit: exam);
  }

  void _showExamNilai(Exam exam) {
    // Navigate to exam scores/grades screen (placeholder)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur Nilai akan segera hadir'),
        backgroundColor: CustomColor.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          '${widget.subjectName} - ${widget.className}',
          style: const TextStyle(
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
          // Search bar and add button
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SubjectSearchBar(
                  searchController: _searchController,
                  onAddPressed: () => _navigateToCreateExam(),
                ),
                const SizedBox(height: 16),
                // Exam count badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [ExamCountBadge(examCount: _exams.length)],
                ),
              ],
            ),
          ),
          // Exam list or empty state
          Expanded(
            child: _exams.isEmpty ? _buildEmptyState() : _buildExamList(),
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
              'Belum ada ulangan, klik tombol Tambah untuk membuat ulangan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: CustomColor.textGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredExams.length,
      itemBuilder: (context, index) {
        final exam = _filteredExams[index];
        return ExamCard(
          exam: exam,
          onDetail: () => _showExamDetail(exam),
          onNilai: () => _showExamNilai(exam),
          onDelete: () => _deleteExam(exam),
        );
      },
    );
  }
}
