import 'package:flutter/material.dart';
import '/model/teacher_model.dart';
import '/style/custom_color.dart';
import '/widget/edit_profile_modal.dart';
import '/widget/keamanan_modal.dart';
import '/widget/pengaturan_akun_modal.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = Teacher(
      name: 'Budi Santoso',
      subject: 'Guru Matematika',
      profilePictureUrl: 'https://picsum.photos/200',
      numberOfClasses: 4,
      numberOfExams: 12,
      numberOfStudents: 128,
      numberOfQuestions: 350,
      email: 'budi.santoso@email.com',
      phoneNumber: '+62 812-3456-7890',
      school: 'SMA Negeri 1 Jakarta',
      joinDate: '1 September 2025',
    );

    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColor.backgroundColor,
        surfaceTintColor: CustomColor.backgroundColor,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: CustomColor.textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(teacher, context),
          const SizedBox(height: 24.0),
          _buildStatistics(teacher),
          const SizedBox(height: 24.0),
          _buildContactInfo(teacher),
          const SizedBox(height: 24.0),
          _buildSettings(context),
          const SizedBox(height: 24.0),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Teacher teacher, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      shadowColor: CustomColor.textBlack.withValues(alpha: 0.2),
      color: CustomColor.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: CustomColor.primaryColor,
              child: Icon(Icons.person, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 16.0),
            Text(
              teacher.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColor.textBlack,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              teacher.subject,
              style: TextStyle(
                color: CustomColor.textBlack.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => EditProfileModal(
                    currentName: teacher.name,
                    currentEmail: teacher.email,
                    currentPhone: teacher.phoneNumber,
                    currentSchool: teacher.school,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.accentColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              icon: const Icon(
                Icons.edit,
                color: CustomColor.primaryColor,
                size: 16,
              ),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: CustomColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(Teacher teacher) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      shadowColor: CustomColor.textBlack.withValues(alpha: 0.2),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistik',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CustomColor.textBlack,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'assets/icons/book.png',
                    '${teacher.numberOfClasses}',
                    'Kelas',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatItem(
                    'assets/icons/exam.png',
                    '${teacher.numberOfExams}',
                    'Ulangan',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'assets/icons/profile.png',
                    '${teacher.numberOfStudents}',
                    'Murid',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatItem(
                    'assets/icons/exam.png',
                    '${teacher.numberOfQuestions}',
                    'Soal',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String iconPath, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 20,
            height: 20,
            color: CustomColor.primaryColor,
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CustomColor.textBlack,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            style: TextStyle(
              color: CustomColor.textBlack.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(Teacher teacher) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      shadowColor: CustomColor.textBlack.withValues(alpha: 0.2),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Kontak',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CustomColor.textBlack,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildContactRow(Icons.email_outlined, 'Email', teacher.email),
            const Divider(height: 24, thickness: 0.5),
            _buildContactRow(
              Icons.phone_outlined,
              'No. Telepon',
              teacher.phoneNumber,
            ),
            const Divider(height: 24, thickness: 0.5),
            _buildContactRow(Icons.school_outlined, 'Sekolah', teacher.school),
            const Divider(height: 24, thickness: 0.5),
            _buildContactRow(
              Icons.calendar_today_outlined,
              'Bergabung Sejak',
              teacher.joinDate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 22,
              color: CustomColor.textBlack.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: CustomColor.textBlack.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.textBlack,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      shadowColor: CustomColor.textBlack.withValues(alpha: 0.2),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pengaturan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CustomColor.textBlack,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildSettingItem(
              Icons.settings_outlined,
              'Pengaturan Akun',
              context,
            ),
            const Divider(height: 16, thickness: 0.5),
            _buildSettingItem(Icons.security_outlined, 'Keamanan', context),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Pengaturan Akun') {
          showDialog(
            context: context,
            builder: (BuildContext context) => const PengaturanAkunModal(),
          );
        } else if (title == 'Keamanan') {
          showDialog(
            context: context,
            builder: (BuildContext context) => const KeamananModal(),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: CustomColor.textBlack.withValues(alpha: 0.7)),
                const SizedBox(width: 16.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: CustomColor.textBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: CustomColor.textBlack.withValues(alpha: 0.6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    const Color logoutColor = Color(0xFFD32F2F);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: logoutColor, width: 1.5),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: ListTile(
        leading: const Icon(Icons.logout, color: logoutColor),
        title: const Text(
          'Keluar',
          style: TextStyle(color: logoutColor, fontWeight: FontWeight.bold),
        ),
        onTap: () {},
      ),
    );
  }
}
