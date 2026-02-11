import 'package:flutter/material.dart';
import 'package:mentor_a/model/teacher_material_model.dart';
import 'package:mentor_a/style/custom_color.dart';

/// Displays a single attachment row (file or link) with an optional remove button.
class AttachmentItem extends StatelessWidget {
  final MaterialAttachment attachment;
  final VoidCallback? onRemove;

  const AttachmentItem({super.key, required this.attachment, this.onRemove});

  IconData get _icon {
    return attachment.type == AttachmentType.file
        ? Icons.insert_drive_file_rounded
        : Icons.link_rounded;
  }

  Color get _iconBackground {
    return attachment.type == AttachmentType.file
        ? const Color(0xFFEDE7F6) // light purple
        : CustomColor.lightAccent;
  }

  Color get _iconColor {
    return attachment.type == AttachmentType.file
        ? const Color(0xFF7C4DFF) // purple
        : CustomColor.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColor.borderGrey),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, color: _iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.textBlack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (attachment.detail != null)
                  Text(
                    attachment.detail!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: CustomColor.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (onRemove != null)
            GestureDetector(
              onTap: onRemove,
              child: const Icon(
                Icons.close,
                size: 18,
                color: CustomColor.textGrey,
              ),
            ),
        ],
      ),
    );
  }
}
