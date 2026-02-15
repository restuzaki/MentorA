import 'package:flutter/material.dart';
import '/style/custom_color.dart';

class PengaturanAkunModal extends StatefulWidget {
  const PengaturanAkunModal({super.key});

  @override
  State<PengaturanAkunModal> createState() => _PengaturanAkunModalState();
}

class _PengaturanAkunModalState extends State<PengaturanAkunModal> {
  String _selectedLanguage = 'Bahasa Indonesia';
  bool _emailNotifications = true;
  bool _pushNotifications = true;

  final List<String> _languages = ['Bahasa Indonesia', 'English'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pengaturan Akun',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.textBlack,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Language Dropdown
                const Text(
                  'Bahasa',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.textBlack,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedLanguage,
                  decoration: InputDecoration(
                    filled: false,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: CustomColor.borderGrey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: CustomColor.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: CustomColor.textBlack,
                  ),
                  style: const TextStyle(
                    color: CustomColor.textBlack,
                    fontSize: 14,
                  ),
                  dropdownColor: Colors.white,
                  items: _languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Email Notifications Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifikasi Email',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.textBlack,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Terima update via email',
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.textBlack.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _emailNotifications,
                      onChanged: (bool value) {
                        setState(() {
                          _emailNotifications = value;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: CustomColor.primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: CustomColor.borderGrey,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Push Notifications Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifikasi Push',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.textBlack,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Terima notifikasi langsung',
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.textBlack.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _pushNotifications,
                      onChanged: (bool value) {
                        setState(() {
                          _pushNotifications = value;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: CustomColor.primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: CustomColor.borderGrey,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: CustomColor.borderGrey,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(
                            color: CustomColor.textBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle save logic here
                          Navigator.of(context).pop({
                            'language': _selectedLanguage,
                            'emailNotifications': _emailNotifications,
                            'pushNotifications': _pushNotifications,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: CustomColor.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
