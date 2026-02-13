import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_a/model/subject_model.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/delete_confirmation_dialog.dart';
import 'package:mentor_a/widget/question_card.dart';

/// Screen for creating/editing exams with inline question form
class CreateExamScreen extends StatefulWidget {
  final String subjectName;
  final String className;
  final Exam? examToEdit;

  const CreateExamScreen({
    super.key,
    required this.subjectName,
    required this.className,
    this.examToEdit,
  });

  @override
  State<CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _formKey2 = GlobalKey();

  // Focus nodes for better focus management
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _questionTextFocusNode = FocusNode();

  // Loading state
  bool _isSaving = false;

  // Track if there are unsaved changes
  bool _hasUnsavedChanges = false;

  // Exam details controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  DateTime? _selectedDate;

  // Questions list
  List<Question> _questions = [];

  // Inline form state
  bool _isShowingForm = false;
  bool _isEditingQuestion = false;
  Question? _editingQuestion;
  int? _editingQuestionIndex;

  // Question form controllers
  final TextEditingController _questionTextController = TextEditingController();
  QuestionType? _selectedQuestionType;
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  String? _correctAnswerId;

  bool _isEditingExam = false;

  @override
  void initState() {
    super.initState();
    if (widget.examToEdit != null) {
      _isEditingExam = true;
      _loadExamData();
    }
  }

  void _loadExamData() {
    final exam = widget.examToEdit!;
    _titleController.text = exam.title;
    _selectedDate = exam.date;
    _durationController.text = exam.duration.toString();
    _questions = List.from(exam.questions);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _questionTextController.dispose();
    _scrollController.dispose();
    _titleFocusNode.dispose();
    _questionTextFocusNode.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: CustomColor.primaryColor,
              onPrimary: Colors.white,
              onSurface: CustomColor.textBlack,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showQuestionForm() {
    setState(() {
      _isShowingForm = true;
      _isEditingQuestion = false;
      _clearQuestionForm();
    });
    _scrollToForm();
    // Focus on question text field after animation
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        _questionTextFocusNode.requestFocus();
      }
    });
  }

  void _editQuestion(int index) {
    final question = _questions[index];
    setState(() {
      _isShowingForm = true;
      _isEditingQuestion = true;
      _editingQuestion = question;
      _editingQuestionIndex = index;
      _selectedQuestionType = question.type;
      _questionTextController.text = question.questionText;

      if (question.isMultipleChoice) {
        for (int i = 0; i < question.options.length && i < 4; i++) {
          _optionControllers[i].text = question.options[i].text;
        }
        _correctAnswerId = question.correctAnswer;
      }
    });
    _scrollToForm();
    // Focus on question text field
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        _questionTextFocusNode.requestFocus();
      }
    });
  }

  void _scrollToForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey2.currentContext != null) {
        Scrollable.ensureVisible(
          _formKey2.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _clearQuestionForm() {
    _questionTextController.clear();
    _selectedQuestionType = null;
    for (var controller in _optionControllers) {
      controller.clear();
    }
    _correctAnswerId = null;
    _editingQuestion = null;
    _editingQuestionIndex = null;
  }

  void _cancelQuestionForm() {
    // Check if there's unsaved work
    if (_questionTextController.text.trim().isNotEmpty ||
        _optionControllers.any((c) => c.text.trim().isNotEmpty)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Batalkan Perubahan?'),
          content: const Text(
            'Anda memiliki perubahan yang belum disimpan. Yakin ingin membatalkan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog first
                Future.microtask(() {
                  if (mounted) {
                    setState(() {
                      _isShowingForm = false;
                      _clearQuestionForm();
                    });
                  }
                });
              },
              child: const Text(
                'Ya, Batalkan',
                style: TextStyle(color: CustomColor.errorRed),
              ),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _isShowingForm = false;
        _clearQuestionForm();
      });
    }
  }

  void _saveQuestion() {
    if (_questionTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pertanyaan tidak boleh kosong'),
          backgroundColor: CustomColor.errorRed,
        ),
      );
      return;
    }

    if (_selectedQuestionType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tipe soal'),
          backgroundColor: CustomColor.errorRed,
        ),
      );
      return;
    }

    List<AnswerOption> options = [];
    if (_selectedQuestionType == QuestionType.multipleChoice) {
      // Validate all options are filled
      for (var i = 0; i < 4; i++) {
        if (_optionControllers[i].text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Pilihan ${String.fromCharCode(65 + i)} tidak boleh kosong',
              ),
              backgroundColor: CustomColor.errorRed,
            ),
          );
          return;
        }
      }

      // Validate correct answer is selected
      if (_correctAnswerId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih jawaban yang benar'),
            backgroundColor: CustomColor.errorRed,
          ),
        );
        return;
      }

      // Create options
      options = [
        AnswerOption(
          id: 'A',
          label: 'A',
          text: _optionControllers[0].text.trim(),
        ),
        AnswerOption(
          id: 'B',
          label: 'B',
          text: _optionControllers[1].text.trim(),
        ),
        AnswerOption(
          id: 'C',
          label: 'C',
          text: _optionControllers[2].text.trim(),
        ),
        AnswerOption(
          id: 'D',
          label: 'D',
          text: _optionControllers[3].text.trim(),
        ),
      ];
    }

    final newQuestion = Question(
      id:
          _editingQuestion?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      questionText: _questionTextController.text.trim(),
      type: _selectedQuestionType!,
      options: options,
      correctAnswer: _correctAnswerId ?? '',
    );

    setState(() {
      if (_isEditingQuestion && _editingQuestionIndex != null) {
        _questions[_editingQuestionIndex!] = newQuestion;
      } else {
        _questions.add(newQuestion);
      }
      _isShowingForm = false;
      _clearQuestionForm();
      _hasUnsavedChanges = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Soal berhasil disimpan'),
        backgroundColor: CustomColor.successGreen,
      ),
    );
  }

  void _deleteQuestion(int index) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: 'Hapus Soal',
        itemName: 'soal ini',
        onConfirm: () {
          setState(() {
            _questions.removeAt(index);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Soal berhasil dihapus'),
              backgroundColor: CustomColor.errorRed,
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveExam() async {
    if (_isSaving) return; // Prevent double submission

    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih tanggal ulangan'),
            backgroundColor: CustomColor.errorRed,
          ),
        );
        return;
      }

      if (_questions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tambahkan minimal satu soal'),
            backgroundColor: CustomColor.errorRed,
          ),
        );
        return;
      }

      final exam = Exam(
        id:
            widget.examToEdit?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        date: _selectedDate!,
        duration: int.parse(_durationController.text),
        questionCount: _questions.length,
        subjectName: widget.subjectName,
        className: widget.className,
        questions: _questions,
      );

      Navigator.pop(context, exam);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_hasUnsavedChanges || _isShowingForm) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Keluar Tanpa Menyimpan?'),
              content: const Text(
                'Anda memiliki perubahan yang belum disimpan. Yakin ingin keluar?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'Ya, Keluar',
                    style: TextStyle(color: CustomColor.errorRed),
                  ),
                ),
              ],
            ),
          );
          return shouldPop ?? false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        appBar: AppBar(
          title: Text(
            _isEditingExam ? 'Edit Ulangan Harian' : 'Buat Ulangan Harian',
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
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exam details section
                    const Text(
                      'Detail Ulangan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.textBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _titleController,
                      label: 'Judul Ulangan',
                      hint: 'Ulangan Harian Bab 3',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Judul ulangan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildDateField()),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _durationController,
                            label: 'Durasi (menit)',
                            hint: '90',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Durasi tidak boleh kosong';
                              }
                              if (int.tryParse(value) == null ||
                                  int.parse(value) <= 0) {
                                return 'Durasi harus berupa angka positif';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Questions section header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Soal-soal (${_questions.length})',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.textBlack,
                          ),
                        ),
                        if (!_isShowingForm)
                          ElevatedButton.icon(
                            onPressed: _showQuestionForm,
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Tambah Soal'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Questions list
                    if (_questions.isEmpty && !_isShowingForm)
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.quiz_outlined,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Belum ada soal',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Klik tombol "Tambah Soal" untuk mulai',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ..._questions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final question = entry.value;
                        return QuestionCard(
                          questionNumber: index + 1,
                          question: question,
                          onEdit: () => _editQuestion(index),
                          onDelete: () => _deleteQuestion(index),
                        );
                      }).toList(),

                    // Inline question form
                    if (_isShowingForm) ...[
                      const SizedBox(height: 16),
                      Container(
                        key: _formKey2,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: CustomColor.primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Form header
                            Text(
                              _isEditingQuestion
                                  ? 'Edit Soal'
                                  : 'Tambah Soal Baru',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: CustomColor.textBlack,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Question type dropdown
                            _buildDropdown(
                              label: 'Tipe Soal',
                              hint: 'Pilih tipe soal',
                              value: _selectedQuestionType,
                              items: QuestionType.values,
                              onChanged: (QuestionType? newValue) {
                                setState(() {
                                  _selectedQuestionType = newValue;
                                  if (newValue == QuestionType.essay) {
                                    _correctAnswerId = null;
                                    for (var controller in _optionControllers) {
                                      controller.clear();
                                    }
                                  }
                                });
                              },
                              itemBuilder: (type) => type.displayName,
                            ),
                            const SizedBox(height: 16),

                            // Question text
                            _buildTextField(
                              controller: _questionTextController,
                              label: 'Pertanyaan',
                              hint: 'Tulis pertanyaan di sini...',
                              maxLines: 3,
                              focusNode: _questionTextFocusNode,
                            ),

                            // Multiple choice options
                            if (_selectedQuestionType ==
                                QuestionType.multipleChoice) ...[
                              const SizedBox(height: 16),
                              const Text(
                                'Pilihan Jawaban',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.textBlack,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...[0, 1, 2, 3].map((index) {
                                final label = String.fromCharCode(
                                  65 + index,
                                ); // A, B, C, D
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildOptionField(
                                    label: 'Pilihan $label',
                                    controller: _optionControllers[index],
                                    optionId: label,
                                  ),
                                );
                              }).toList(),
                              const SizedBox(height: 8),
                              const Text(
                                'Jawaban Benar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.textBlack,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildCorrectAnswerSelector(),
                            ],

                            const SizedBox(height: 24),

                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _saveQuestion,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: CustomColor.primaryColor,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    child: const Text('Simpan Soal'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: _cancelQuestionForm,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: CustomColor.textBlack,
                                      side: const BorderSide(
                                        color: CustomColor.borderGrey,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    child: const Text('Batal'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Save exam button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveExam,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.primaryColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade300,
                          disabledForegroundColor: Colors.grey.shade600,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text('Simpan Ulangan'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isSaving)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    FocusNode? focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: CustomColor.textBlack,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          focusNode: focusNode,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: CustomColor.hintGrey,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: CustomColor.primaryColor,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: CustomColor.primaryColor,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: CustomColor.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: CustomColor.errorRed),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: CustomColor.errorRed,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: CustomColor.textBlack,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: CustomColor.primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                        : 'Pilih tanggal',
                    style: TextStyle(
                      fontSize: 14,
                      color: _selectedDate != null
                          ? CustomColor.textBlack
                          : CustomColor.hintGrey,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: CustomColor.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required QuestionType? value,
    required List<QuestionType> items,
    required void Function(QuestionType?) onChanged,
    required String Function(QuestionType) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: CustomColor.textBlack,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: CustomColor.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<QuestionType>(
              value: value,
              hint: Text(
                hint,
                style: const TextStyle(
                  fontSize: 14,
                  color: CustomColor.hintGrey,
                ),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: CustomColor.primaryColor,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: CustomColor.textBlack,
              ),
              items: items.map((QuestionType type) {
                return DropdownMenuItem<QuestionType>(
                  value: type,
                  child: Text(itemBuilder(type)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionField({
    required String label,
    required TextEditingController controller,
    required String optionId,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: CustomColor.hintGrey,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: CustomColor.primaryColor,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorrectAnswerSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ['A', 'B', 'C', 'D'].map((option) {
        final isSelected = _correctAnswerId == option;
        return InkWell(
          onTap: () {
            setState(() {
              _correctAnswerId = option;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? CustomColor.successGreen
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? CustomColor.successGreen
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : CustomColor.textGrey,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
