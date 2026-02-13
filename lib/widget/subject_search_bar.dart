import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

/// A reusable search bar row with a "+" action button.
/// Used on both student and teacher subject screens.
class SubjectSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback onAddPressed;
  final TextEditingController? searchController;

  const SubjectSearchBar({
    super.key,
    this.hintText = "Cari mata pelajaran atau kelas...",
    required this.onAddPressed,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onAddPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CustomColor.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
