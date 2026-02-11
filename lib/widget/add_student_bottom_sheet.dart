import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/custom_text_field.dart';

/// Bottom sheet for adding a new student with name and email fields.
class AddStudentBottomSheet extends StatefulWidget {
  const AddStudentBottomSheet({super.key});

  @override
  State<AddStudentBottomSheet> createState() => _AddStudentBottomSheetState();
}

class _AddStudentBottomSheetState extends State<AddStudentBottomSheet> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama murid tidak boleh kosong'),
          backgroundColor: CustomColor.errorRed,
        ),
      );
      return;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email murid tidak boleh kosong'),
          backgroundColor: CustomColor.errorRed,
        ),
      );
      return;
    }

    Navigator.pop(context, {'name': name, 'email': email});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tambah Murid Baru',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColor.textBlack,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Nama murid',
            hintText: 'Nama murid...',
            controller: _nameController,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Email murid',
            hintText: 'Email murid',
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Batal'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CustomColor.textBlack,
                    side: const BorderSide(color: CustomColor.borderGrey),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
