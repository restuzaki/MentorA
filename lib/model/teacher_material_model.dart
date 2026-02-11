/// Represents the type of attachment in a teacher material.
enum AttachmentType { file, link }

/// A single attachment (file or link) within a [TeacherMaterial].
class MaterialAttachment {
  final String name;
  final String? detail; // file size string or URL
  final AttachmentType type;

  MaterialAttachment({required this.name, this.detail, required this.type});
}

/// A subject material / sub-chapter created by a teacher.
class TeacherMaterial {
  String title;
  List<MaterialAttachment> attachments;

  TeacherMaterial({required this.title, List<MaterialAttachment>? attachments})
    : attachments = attachments ?? [];
}
