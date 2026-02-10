import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_a/screen/student/exam_question_student_screen.dart';
import 'package:mentor_a/screen/student/exam_review_student_screen.dart';
import '../../model/subject_model.dart';

class ExamStudentScreen extends StatefulWidget {
  const ExamStudentScreen({super.key});

  @override
  State<ExamStudentScreen> createState() => _ExamStudentScreenState();
}

class _ExamStudentScreenState extends State<ExamStudentScreen> {
  final List<Map<String, dynamic>> daftarUlangan = [
    {
      "judul": "Ulangan Harian Bab 1 - Aljabar",
      "tanggal": DateTime(2026, 1, 20),
      "durasi": "90 menit",
      "jumlahSoal": "5 Soal",
      "isStarted": false,
      "isCompleted": false,
      "questions": [
        Question(
          id: "1",
          questionText: "Tentukan nilai x dari persamaan berikut:\n2x + 6 = 14",
          type: "Pilihan Ganda",
          options: ["A. 3", "B. 4", "C. 5", "D. 6"],
          correctAnswer: "B. 4",
          explanation: "2x = 14 - 6 => 2x = 8 => x = 4.",
          selectedOption: "B. 4",
        ),
        Question(
          id: "2",
          questionText: "Tentukan nilai x dari persamaan berikut:\n5x - 10 = 0",
          type: "Pilihan Ganda",
          options: ["A. 1", "B. 2", "C. 3", "D. 4"],
          correctAnswer: "B. 2",
          explanation: "5x = 10 => x = 2.",
          selectedOption: "A. 1",
        ),
      ],
    },
    {
      "judul": "Ulangan Harian Bab 2 - Geometri ruang datar",
      "tanggal": DateTime(2026, 2, 11),
      "durasi": "90 menit",
      "jumlahSoal": "30 Soal",
      "isStarted": false,
      "isCompleted": false,
      "questions": [],
    },
  ];

  Future<void> _navigateToExam(Map<String, dynamic> exam) async {
    // Navigator push sekarang menunggu kembalian berupa List<Question>
    final dynamic result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExamQuestionStudentScreen(examTitle: exam['judul']),
      ),
    );

    // LOGIKA PERBAIKAN:
    // Jika result adalah List, berarti user menekan 'Kumpulkan'
    if (result != null && result is List<Question>) {
      setState(() {
        exam['questions'] = result; // Simpan jawaban yang dikirim balik
        exam['isCompleted'] = true;
        exam['isStarted'] = false;
      });
    }
    // Jika result bukan List tapi user keluar dari halaman (misal tekan back)
    // dan ada minimal satu jawaban yang terisi, anggap 'isStarted'
    else {
      setState(() {
        // Cek apakah ada soal yang sudah dijawab (opsional)
        exam['isStarted'] = true;
      });
    }
  }

  void _navigateToReview(Map<String, dynamic> exam) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamReviewScreen(
          questions: List<Question>.from(exam['questions']),
          examTitle: exam['judul'],
        ),
      ),
    );
  }

  void _handleExamAction(Map<String, dynamic> exam) {
    if (exam['isCompleted'] == true) {
      _navigateToReview(exam);
    } else if (exam['isStarted'] == true) {
      _navigateToExam(exam);
    } else {
      _showExamDetail(context, exam);
    }
  }

  void _showExamDetail(BuildContext context, Map<String, dynamic> exam) {
    showDialog(
      context: context,
      builder: (context) =>
          ExamDetailDialog(exam: exam, onStart: () => _navigateToExam(exam)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Ulangan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Cari mata pelajaran atau kelas...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Daftar Ulangan (${daftarUlangan.length})",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: daftarUlangan.length,
                itemBuilder: (context, index) {
                  return CardUlangan(
                    data: daftarUlangan[index],
                    onTapAction: () => _handleExamAction(daftarUlangan[index]),
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

class CardUlangan extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTapAction;

  const CardUlangan({super.key, required this.data, required this.onTapAction});

  @override
  Widget build(BuildContext context) {
    DateTime tanggalUlangan = data['tanggal'];
    DateTime hariIni = DateTime.now();
    bool isAvailable =
        hariIni.isAfter(tanggalUlangan) ||
        DateUtils.isSameDay(hariIni, tanggalUlangan);
    bool isStarted = data['isStarted'] ?? false;
    bool isCompleted = data['isCompleted'] ?? false;

    String buttonText = "Mulai";
    Color buttonColor = const Color(0xFF4A89DC);
    Color textColor = Colors.white;

    if (isCompleted) {
      buttonText = "Cek Review";
      buttonColor = const Color(0xFFE2F6E9);
      textColor = Colors.green;
    } else if (isStarted) {
      buttonText = "Lanjutkan";
      buttonColor = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data['judul'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isCompleted)
                const Icon(Icons.check_circle, color: Colors.green, size: 22),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            DateFormat('d MMMM yyyy', 'id_ID').format(tanggalUlangan),
          ),
          _buildInfoRow(Icons.access_time, data['durasi']),
          _buildInfoRow(Icons.description_outlined, data['jumlahSoal']),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAvailable ? onTapAction : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class ExamDetailDialog extends StatelessWidget {
  final Map<String, dynamic> exam;
  final VoidCallback onStart;
  const ExamDetailDialog({
    super.key,
    required this.exam,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Ulangan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildField("Judul Ulangan", exam['judul']),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildField("Durasi", exam['durasi'])),
                const SizedBox(width: 12),
                Expanded(child: _buildField("Jumlah Soal", exam['jumlahSoal'])),
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
                      onStart();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A89DC),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Mulai Sekarang"),
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
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
