import 'package:flutter/material.dart';
import 'package:mentor_a/screen/login_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  final String role;

  const RegisterScreen({super.key, required this.role});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // --- CONTROLLER DITARUH DI SINI AGAR TEKS TIDAK HILANG ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  const Text(
                    "Selamat Datang 🚀📚",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Lengkapi formulir dibawah ini sebagai ${widget.role}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Form Fields
            _buildLabel("Nama Lengkap"),
            _buildTextField(_nameController, "Masukkan Nama Lengkap"),

            const SizedBox(height: 16),
            _buildLabel("Email"),
            _buildTextField(
              _emailController,
              "Masukkan Email",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),
            _buildLabel("Kata Sandi"),
            _buildPasswordField(
              _passwordController,
              "Masukkan Kata Sandi",
              _obscurePassword,
              () => setState(() => _obscurePassword = !_obscurePassword),
            ),

            const SizedBox(height: 16),
            _buildLabel("Konfirmasi Kata Sandi"),
            _buildPasswordField(
              _confirmPasswordController,
              "Masukkan Kata Sandi",
              _obscureConfirmPassword,
              () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
            ),

            const SizedBox(height: 40),

            CustomChoiceButton(
              text: "Daftar",
              backgroundColor: const Color(0xFF447DDA),
              textColor: Colors.white,
              onPressed: () {
                // print("Mendaftar sebagai ${widget.role}");
                // print("Nama: ${_nameController.text}");
              },
            ),

            const SizedBox(height: 20),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah memiliki akun? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Masuk",
                      style: TextStyle(
                        color: CustomColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String hint,
    bool obscure,
    VoidCallback toggle,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.grey,
          ),
          onPressed: toggle,
        ),
      ),
    );
  }
}
