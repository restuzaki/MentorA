import 'package:flutter/material.dart';
import 'package:mentor_a/style/custom_color.dart';

class CustomBottomNavStudent extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavStudent({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: CustomColor.backgroundColor,
      selectedItemColor: CustomColor.primaryColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: [
        _buildNavItem("assets/icons/home.png", "Home", 0),
        _buildNavItem("assets/icons/book.png", "Belajar", 1),
        _buildNavItem("assets/icons/exam.png", "Ulangan", 2),
        _buildNavItem("assets/icons/chat.png", "AI Chat", 3),
        _buildNavItem("assets/icons/profile.png", "Profil", 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String assetPath,
    String label,
    int index,
  ) {
    bool isSelected = currentIndex == index;

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Image.asset(
          assetPath,
          height: 24,
          width: 24,
          color: isSelected ? CustomColor.primaryColor : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
