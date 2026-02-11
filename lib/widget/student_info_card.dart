import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Card showing student count and action buttons (Lihat Daftar, Undangan).
class StudentInfoCard extends StatelessWidget {
  final int studentCount;
  final VoidCallback onViewList;
  final VoidCallback onInvite;

  const StudentInfoCard({
    super.key,
    required this.studentCount,
    required this.onViewList,
    required this.onInvite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Murid',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColor.textBlack,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CustomColor.lightAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: CustomColor.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$studentCount Murid',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.textBlack,
                    ),
                  ),
                  const Text(
                    'Terdaftar di kelas ini',
                    style: TextStyle(fontSize: 12, color: CustomColor.textGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Lihat Daftar button
              ElevatedButton.icon(
                onPressed: onViewList,
                icon: const Icon(Icons.groups_rounded, size: 18),
                label: const Text('Lihat Daftar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Undangan button
              OutlinedButton.icon(
                onPressed: onInvite,
                icon: const Icon(Icons.share_rounded, size: 18),
                label: const Text('Undangan'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: CustomColor.textBlack,
                  side: const BorderSide(color: CustomColor.borderGrey),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
