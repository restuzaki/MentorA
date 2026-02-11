import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// A list item widget representing a student with view and edit modes.
/// In view mode, shows student name with edit and delete icons.
/// In edit mode, shows text field with save and cancel icons.
class StudentListItem extends StatefulWidget {
  final String studentName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(String) onSave;

  const StudentListItem({
    super.key,
    required this.studentName,
    required this.onEdit,
    required this.onDelete,
    required this.onSave,
  });

  @override
  State<StudentListItem> createState() => _StudentListItemState();
}

class _StudentListItemState extends State<StudentListItem> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.studentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEdit() {
    setState(() {
      _isEditing = true;
      _controller.text = widget.studentName;
    });
    widget.onEdit();
  }

  void _saveEdit() {
    final newName = _controller.text.trim();
    if (newName.isNotEmpty) {
      widget.onSave(newName);
      setState(() => _isEditing = false);
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _controller.text = widget.studentName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColor.borderGrey),
      ),
      child: Row(
        children: [
          Expanded(
            child: _isEditing
                ? TextField(
                    controller: _controller,
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 15,
                      color: CustomColor.textBlack,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nama murid...',
                      hintStyle: TextStyle(color: CustomColor.hintGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CustomColor.borderGrey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CustomColor.borderGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CustomColor.primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      isDense: true,
                    ),
                  )
                : Text(
                    widget.studentName,
                    style: const TextStyle(
                      fontSize: 15,
                      color: CustomColor.textBlack,
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          if (_isEditing) ...[
            // Save button (checkmark)
            GestureDetector(
              onTap: _saveEdit,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 18),
              ),
            ),
            const SizedBox(width: 8),
            // Cancel button (X)
            GestureDetector(
              onTap: _cancelEdit,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColor.borderGrey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.close,
                  color: CustomColor.textGrey,
                  size: 18,
                ),
              ),
            ),
          ] else ...[
            // Edit button (blue pencil)
            GestureDetector(
              onTap: _startEdit,
              child: Container(
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.edit,
                  color: CustomColor.primaryColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 4),
            // Delete button (red trash)
            GestureDetector(
              onTap: widget.onDelete,
              child: Container(
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.delete,
                  color: CustomColor.errorRed,
                  size: 20,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
