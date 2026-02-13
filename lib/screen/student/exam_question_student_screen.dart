import 'package:flutter/material.dart';
import '../../model/subject_model.dart';

class ExamQuestionStudentScreen extends StatefulWidget {
  final String examTitle;
  const ExamQuestionStudentScreen({super.key, required this.examTitle});

  @override
  State<ExamQuestionStudentScreen> createState() =>
      _ExamQuestionStudentScreenState();
}

class _ExamQuestionStudentScreenState extends State<ExamQuestionStudentScreen> {
  int _currentPage = 0;
  final int _itemsPerPage = 3; // Tetap 3

  final Map<String, TextEditingController> _controllers = {};

  final List<Question> _allQuestions = [
    Question(
      id: "1",
      questionText: "Tentukan nilai x dari persamaan berikut:\n2x + 6 = 14",
      type: QuestionType.multipleChoice,
      options: [
        AnswerOption(id: 'A', label: 'A', text: '3'),
        AnswerOption(id: 'B', label: 'B', text: '4'),
        AnswerOption(id: 'C', label: 'C', text: '5'),
        AnswerOption(id: 'D', label: 'D', text: '6'),
      ],
      correctAnswer: "B",
      explanation:
          "2x = 14 - 6 => 2x = 8. Kemudian bagi dengan 2: x = 8 / 2 = 4.",
    ),
    Question(
      id: "2",
      questionText: "Tentukan nilai x dari persamaan berikut:\n5x - 10 = 0",
      type: QuestionType.multipleChoice,
      options: [
        AnswerOption(id: 'A', label: 'A', text: '1'),
        AnswerOption(id: 'B', label: 'B', text: '2'),
        AnswerOption(id: 'C', label: 'C', text: '3'),
        AnswerOption(id: 'D', label: 'D', text: '4'),
      ],
      correctAnswer: "B",
      explanation: "5x = 10. Kemudian bagi dengan 5: x = 10 / 5 = 2.",
    ),
    Question(
      id: "3",
      questionText: "Tentukan nilai x dari persamaan berikut:\nx + 7 = 12",
      type: QuestionType.multipleChoice,
      options: [
        AnswerOption(id: 'A', label: 'A', text: '3'),
        AnswerOption(id: 'B', label: 'B', text: '4'),
        AnswerOption(id: 'C', label: 'C', text: '5'),
        AnswerOption(id: 'D', label: 'D', text: '6'),
      ],
      correctAnswer: "C",
      explanation: "x = 12 - 7. Hasilnya adalah x = 5.",
    ),
    Question(
      id: "4",
      questionText: "Tentukan nilai x dari persamaan berikut:\n5x - 10 = 0",
      type: QuestionType.essay,
      options: [],
      correctAnswer: "2",
      explanation: "5x = 10, sehingga x = 2.",
    ),
    Question(
      id: "5",
      questionText: "Tentukan nilai x dari persamaan berikut:\nx + 7 = 12",
      type: QuestionType.essay,
      options: [],
      correctAnswer: "5",
      explanation: "x = 12 - 7. Maka nilai x adalah 5.",
    ),
    Question(
      id: "6",
      questionText: "Tentukan nilai x dari persamaan berikut:\n3x - 9 = 6",
      type: QuestionType.multipleChoice,
      options: [
        AnswerOption(id: 'A', label: 'A', text: '3'),
        AnswerOption(id: 'B', label: 'B', text: '5'),
        AnswerOption(id: 'C', label: 'C', text: '7'),
        AnswerOption(id: 'D', label: 'D', text: '9'),
      ],
      correctAnswer: "B",
      explanation: "3x = 15. Maka x = 5.",
    ),
    Question(
      id: "7",
      questionText: "Berapakah nilai x jika 4x = 20?",
      type: QuestionType.essay,
      options: [],
      correctAnswer: "5",
      explanation: "x = 20 / 4 = 5.",
    ),
  ];

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Question> get _currentQuestions {
    int start = _currentPage * _itemsPerPage;
    int end = start + _itemsPerPage;
    return _allQuestions.sublist(
      start,
      end > _allQuestions.length ? _allQuestions.length : end,
    );
  }

  bool get _isLastPage =>
      (_currentPage + 1) * _itemsPerPage >= _allQuestions.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          widget.examTitle,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _currentQuestions.length,
              key: ValueKey('page_$_currentPage'),
              itemBuilder: (context, index) {
                final question = _currentQuestions[index];
                int globalIndex = (_currentPage * _itemsPerPage) + index + 1;
                return _buildQuestionCard(question, globalIndex);
              },
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPage == 0
                        ? const Color(0xFFA6C1E9)
                        : const Color(0xFF4A89DC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _currentPage == 0
                      ? null
                      : () => setState(() => _currentPage--),
                  child: const Text(
                    "Sebelumnya",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A89DC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isLastPage
                      ? null
                      : () => setState(() => _currentPage++),
                  child: const Text(
                    "Selanjutnya",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          if (_isLastPage) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A89DC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _showSubmitDialog,
                child: const Text(
                  "Kumpulkan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Kumpulkan Ulangan?"),
        content: const Text(
          "Apakah kamu yakin ingin menyelesaikan ulangan ini?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A89DC),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(
                context,
                _allQuestions,
              ); // KIRIM DATA SOAL KE HALAMAN SEBELUMNYA
            },
            child: const Text("Ya, Kumpulkan"),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question, int number) {
    bool isEssay = question.isEssay;
    if (isEssay && !_controllers.containsKey(question.id)) {
      _controllers[question.id] = TextEditingController(
        text: question.selectedOption,
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTag(
                "Soal $number",
                const Color(0xFFE8F0FE),
                const Color(0xFF4A89DC),
              ),
              const SizedBox(width: 8),
              _buildTag(
                question.type.displayName,
                Colors.grey.shade100,
                Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            question.questionText,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (!isEssay)
            ...question.options.map(
              (option) => _buildOptionTile(
                question,
                option.id,
                option.label,
                option.text,
              ),
            )
          else
            TextField(
              controller: _controllers[question.id],
              decoration: InputDecoration(
                hintText: "Isi jawaban disini...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) => question.selectedOption = val,
            ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    Question question,
    String optionId,
    String label,
    String text,
  ) {
    bool isSelected = question.selectedOption == optionId;
    return GestureDetector(
      onTap: () => setState(() => question.selectedOption = optionId),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F0FE) : const Color(0xFFF1F3F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A89DC) : Colors.transparent,
          ),
        ),
        child: Text(
          '$label. $text',
          style: TextStyle(
            color: isSelected ? const Color(0xFF4A89DC) : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
