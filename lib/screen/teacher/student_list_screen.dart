import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/student_count_badge.dart';
import 'package:mentor_a/widget/student_list_item.dart';

/// Screen showing the list of students enrolled in a class.
class StudentListScreen extends StatefulWidget {
  final String? className;

  const StudentListScreen({super.key, this.className});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final List<Map<String, String>> _students = [];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  List<Map<String, String>> _filteredStudents = [];
  bool _isAddingStudent = false;

  @override
  void initState() {
    super.initState();
    _filteredStudents = _students;
    _searchController.addListener(_filterStudents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _filterStudents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = _students;
      } else {
        _filteredStudents = _students
            .where((student) => student['name']!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _showAddForm() {
    setState(() {
      _isAddingStudent = true;
      _nameController.clear();
      _emailController.clear();
    });
  }

  void _hideAddForm() {
    setState(() {
      _isAddingStudent = false;
      _nameController.clear();
      _emailController.clear();
    });
  }

  void _saveStudent() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama murid tidak boleh kosong'),
          backgroundColor: CustomColor.errorRed,
        ),
      );
      return;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email murid tidak boleh kosong'),
          backgroundColor: CustomColor.errorRed,
        ),
      );
      return;
    }

    setState(() {
      _students.add({'name': name, 'email': email});
      _filterStudents();
      _isAddingStudent = false;
      _nameController.clear();
      _emailController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Murid $name berhasil ditambahkan'),
        backgroundColor: CustomColor.successGreen,
      ),
    );
  }

  void _editStudent(int index, String newName) {
    setState(() {
      _students[index]['name'] = newName;
      _filterStudents();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nama murid berhasil diperbarui'),
        backgroundColor: CustomColor.successGreen,
      ),
    );
  }

  void _deleteStudent(int index) {
    final studentName = _students[index]['name'];
    setState(() {
      _students.removeAt(index);
      _filterStudents();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Murid $studentName berhasil dihapus'),
        backgroundColor: CustomColor.errorRed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Daftar Murid',
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
          // Search bar and share button
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search field
                TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Cari Nama Murid',
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
                      borderSide: const BorderSide(
                        color: CustomColor.primaryColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Student count badge with add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StudentCountBadge(studentCount: _students.length),
                    ElevatedButton.icon(
                      onPressed: _showAddForm,
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Tambah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                // Inline add student form
                if (_isAddingStudent) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CustomColor.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: CustomColor.borderGrey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tambah Murid Baru',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.textBlack,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _nameController,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Intan N',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: CustomColor.hintGrey,
                            ),
                            filled: true,
                            fillColor: CustomColor.backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: CustomColor.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: CustomColor.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: CustomColor.primaryColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'intanbaik@gmail.com',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: CustomColor.hintGrey,
                            ),
                            filled: true,
                            fillColor: CustomColor.backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: CustomColor.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: CustomColor.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: CustomColor.primaryColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _saveStudent,
                                icon: const Icon(Icons.check, size: 16),
                                label: const Text('Simpan'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColor.primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _hideAddForm,
                                icon: const Icon(Icons.close, size: 16),
                                label: const Text('Batal'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: CustomColor.textBlack,
                                  side: const BorderSide(
                                    color: CustomColor.borderGrey,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Student list or empty state
          Expanded(
            child: _students.isEmpty ? _buildEmptyState() : _buildStudentList(),
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
              Icons.group_add_outlined,
              color: CustomColor.primaryColor,
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Belum ada murid, klik tombol Tambah untuk menambah murid',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: CustomColor.textGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredStudents.length,
      itemBuilder: (context, index) {
        final actualIndex = _students.indexOf(_filteredStudents[index]);
        final student = _filteredStudents[index];
        return StudentListItem(
          studentName: student['name']!,
          onEdit: () {},
          onDelete: () => _deleteStudent(actualIndex),
          onSave: (newName) => _editStudent(actualIndex, newName),
        );
      },
    );
  }
}
