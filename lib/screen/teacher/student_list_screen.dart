import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Placeholder screen showing the list of students enrolled in a class.
class StudentListScreen extends StatelessWidget {
  final String? className;

  const StudentListScreen({super.key, this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          className != null ? 'Murid - $className' : 'Daftar Murid',
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
      body: Center(
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
                Icons.groups_rounded,
                color: CustomColor.primaryColor,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Daftar Murid',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CustomColor.textBlack,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Halaman ini akan menampilkan\ndaftar murid yang terdaftar',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: CustomColor.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}
