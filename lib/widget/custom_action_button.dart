import "package:flutter/material.dart";
import "package:mentor_a/style/custom_color.dart";

class CustomActionDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String hintText;
  final Function(String) onSave;

  const CustomActionDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.hintText,
    required this.onSave,
  });

  @override
  State<CustomActionDialog> createState() => _CustomActionDialogState();
}

class _CustomActionDialogState extends State<CustomActionDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColor.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.subtitle,
              style: const TextStyle(color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE9ECEF),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Batal"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final value = _controller.text;
                      if (value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${widget.title} gagal ditambahkan"),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        widget.onSave(value);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text("$value berhasil ditambahkan"),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Simpan"),
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
