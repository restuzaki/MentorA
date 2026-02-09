import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/custom_button.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/choice_bg.png"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),

          // Bagian Bawah (Teks dan Tombol)
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  const Text(
                    "Masuk sebagai siapa?🚀",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Agar MentorA bisa menyesuaikan fitur dan pengalamanmu.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 40),

                  // Pakai Reusable Button di sini
                  CustomChoiceButton(
                    text: "Guru",
                    onPressed: () {
                      print("Login sebagai Guru");
                    },
                  ),

                  const SizedBox(height: 15),

                  CustomChoiceButton(
                    text: "Murid",
                    onPressed: () {
                      print("Login sebagai Murid");
                    },
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
