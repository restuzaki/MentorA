import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Bottom sheet for choosing attachment type: Upload File or Tambah Link.
class AttachmentBottomSheet extends StatelessWidget {
  final VoidCallback onUploadFile;
  final VoidCallback onAddLink;

  const AttachmentBottomSheet({
    super.key,
    required this.onUploadFile,
    required this.onAddLink,
  });

  /// Show the bottom sheet.
  static void show(
    BuildContext context, {
    required VoidCallback onUploadFile,
    required VoidCallback onAddLink,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: CustomColor.backgroundColor,
      builder: (context) => AttachmentBottomSheet(
        onUploadFile: () {
          Navigator.pop(context);
          onUploadFile();
        },
        onAddLink: () {
          Navigator.pop(context);
          onAddLink();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tambah Lampiran',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CustomColor.textBlack,
            ),
          ),
          const SizedBox(height: 20),
          // Upload File option
          _OptionTile(
            icon: Icons.upload_file_rounded,
            iconBackground: const Color(0xFFEDE7F6),
            iconColor: const Color(0xFF7C4DFF),
            title: 'Upload File',
            subtitle: 'Dokumen, PDF, Video',
            onTap: onUploadFile,
          ),
          const SizedBox(height: 10),
          // Tambah Link option
          _OptionTile(
            icon: Icons.link_rounded,
            iconBackground: CustomColor.lightAccent,
            iconColor: CustomColor.primaryColor,
            title: 'Tambah Link',
            subtitle: 'YouTube, Google Drive, dll',
            onTap: onAddLink,
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: CustomColor.borderGrey),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.textBlack,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: CustomColor.textGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
