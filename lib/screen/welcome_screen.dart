import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentor_a/screen/choice_screen.dart';
import 'package:mentor_a/style/custom_color.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Belajar Lebih Pintar\nTanpa Ribet! 📚✨",
      "subtitle":
          "Bersama MentorA, belajar jadi lebih terarah, seru, dan sesuai kebutuhanmu!",
      "image": "assets/images/welcome1.png",
    },
    {
      "title": "Belajar, Latihan, dan\nNaik Level! 🚀📚",
      "subtitle":
          "Akses materi, kerjakan ulangan dan kuis, serta pantau progres belajarmu bersama MentorA.",
      "image": "assets/images/welcome2.png",
    },
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (_currentPage < onboardingData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChoiceScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => OnboardingContent(
              title: onboardingData[index]["title"]!,
              subtitle: onboardingData[index]["subtitle"]!,
              image: onboardingData[index]["image"]!,
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _navigateToNext,
              style: TextButton.styleFrom(
                backgroundColor: CustomColor.accentColor.withValues(alpha: 0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Lewati",
                style: TextStyle(
                  color: CustomColor.textBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 3. Bottom Controls (Indikator & Tombol Navigasi)
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage > 0
                    ? FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white.withValues(alpha: 0.5),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      )
                    : const SizedBox(width: 48),

                // Dot Indicators
                Row(
                  children: List.generate(
                    onboardingData.length,
                    (index) => buildDot(index: index),
                  ),
                ),

                // Tombol Next / Forward
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white.withValues(alpha: 0.5),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                  onPressed: () {
                    if (_currentPage == onboardingData.length - 1) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk titik indikator
  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: _currentPage == index ? 25 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Color(0xFF0A449B)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, subtitle, image;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CustomColor.primaryColor,
      child: Column(
        children: [
          // Bagian Gambar (Atas)
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.textWhite,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColor.textWhite,
                    ),
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
