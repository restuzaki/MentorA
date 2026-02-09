import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

import '../../model/chatbot_model.dart';

class ChatbotStudentScreen extends StatelessWidget {
  ChatbotStudentScreen({super.key});

  final List<ChatMessage> messages = [
    ChatMessage(
      isAi: true,
      time: "18.14",
      text:
          "Halo! 👋 Aku adalah AI Tutor kamu. Aku siap membantu kamu belajar! Mau bertanya tentang pelajaran apa hari ini?",
    ),
    ChatMessage(isAi: false, time: "18.20", text: "Luas Persegi?"),
    ChatMessage(
      isAi: true,
      time: "18.14",
      text:
          "L = s × s = s²\n\nKeterangan:\n• L = luas\n• s = panjang sisi\n\nContoh:\nJika panjang sisi persegi 4 cm, maka:\n• L = 4 × 4 = 16 cm",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "AI Tutor",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withValues(alpha: 0.1),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // Area Chat
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildChatBubble(messages[index], context);
              },
            ),
          ),

          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message, BuildContext context) {
    return Align(
      alignment: message.isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(message.isAi ? 4 : 20),
            bottomRight: Radius.circular(message.isAi ? 20 : 4),
          ),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isAi) ...[
              Row(
                children: [
                  Image.asset(
                    "assets/icons/stars.png",
                    height: 16,
                    width: 16,
                    color: CustomColor.primaryColor,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "AI Tutor",
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message.text,
              style: const TextStyle(
                color: Color(0xFF334155),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message.time,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          _buildIconButton(Icons.mic_none_outlined),
          const SizedBox(width: 8),
          _buildIconButton(Icons.image_outlined),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tanya AI Tutor...",
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
                fillColor: const Color(0xFFF8FAFC),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: const Color(0xFFE2E8F0),
            child: IconButton(
              icon: const Icon(
                Icons.send_outlined,
                color: Color(0xFF94A3B8),
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF64748B), size: 22),
        onPressed: () {},
      ),
    );
  }
}
