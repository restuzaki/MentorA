import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// A reusable subject list card with a book icon, title, subtitle,
/// and an optional trailing widget (e.g. a "Hapus" button).
/// Used on both student and teacher subject screens.
class SubjectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SubjectCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: CustomColor.backgroundColor,
        shadowColor: Colors.grey,
        elevation: 0.5,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.book_outlined,
              color: CustomColor.primaryColor,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
          trailing: trailing,
        ),
      ),
    );
  }
}
