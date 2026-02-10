import 'package:flutter/material.dart';
import 'package:mentor_a/screen/student/quiz_question_student_screen.dart';
import '../../model/subject_model.dart';
import '../../style/custom_color.dart';

class QuizStudentScreen extends StatefulWidget {
  final String chapterTitle;
  final List<Quiz> quizzes;

  const QuizStudentScreen({
    super.key,
    required this.chapterTitle,
    required this.quizzes,
  });

  @override
  State<QuizStudentScreen> createState() => _QuizStudentScreenState();
}

class _QuizStudentScreenState extends State<QuizStudentScreen> {
  // Fungsi untuk memperbarui status kuis menjadi selesai
  void _completeQuiz(Quiz quiz) {
    setState(() {
      quiz.isCompleted = true;
    });
  }

  void _showQuizDetail(BuildContext context, Quiz quiz) {
    showDialog(
      context: context,
      builder: (context) => QuizDetailDialog(
        quiz: quiz,
        onStart: () => _completeQuiz(quiz), // Callback dikirim ke dialog
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Kumpulan Soal",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Cari Quiz...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = widget.quizzes[index];
                  // Cek apakah kuis sudah selesai
                  bool isDone = quiz.isCompleted;

                  return Card(
                    color: CustomColor.backgroundColor,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      // Jika sudah hijau (isDone), onTap menjadi null sehingga tidak bisa dipencet
                      onTap: isDone
                          ? null
                          : () => _showQuizDetail(context, quiz),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // Berubah warna hijau jika selesai
                          color: isDone
                              ? const Color(0xFFE2F6E9)
                              : const Color(0xFFE8F0FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.description_outlined,
                          // Icon berubah warna hijau jika selesai
                          color: isDone
                              ? Colors.green
                              : CustomColor.primaryColor,
                        ),
                      ),
                      title: Text(
                        widget.chapterTitle,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      subtitle: Text(
                        quiz.title,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      // Tambahkan trailing centang jika sudah selesai untuk memperjelas UI
                      trailing: isDone
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            )
                          : null,
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

class QuizDetailDialog extends StatelessWidget {
  final Quiz quiz;
  final VoidCallback onStart; // Parameter baru untuk callback

  const QuizDetailDialog({
    super.key,
    required this.quiz,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColor.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Quiz",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            _buildField("Judul Quiz", quiz.title),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildField("Tanggal", quiz.date)),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(
                    "Jumlah Soal",
                    quiz.questionCount.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE9ECEF),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Batal"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onStart(); // Panggil callback untuk mengubah status kuis
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuizQuestionStudentScreen(quizTitle: quiz.title),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Mulai Quiz"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(value, style: const TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }
}
