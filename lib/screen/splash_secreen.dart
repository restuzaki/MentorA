import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_a/screen/login_screen.dart';
import 'package:mentor_a/screen/welcome_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isNavigating = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _initializeVideo();
  }

  void _initializeVideo() {
    // Menggunakan video loading asli untuk splash screen
    _controller = VideoPlayerController.asset("assets/videos/splash_logo.mp4")
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      })
      ..addListener(_checkVideoEnd);
  }

  void _checkVideoEnd() {
    // Navigasi ketika video selesai dan belum navigasi
    if (_controller.value.isInitialized &&
        !_controller.value.isPlaying &&
        _controller.value.position >= _controller.value.duration &&
        !_isNavigating) {
      _navigateToNextScreen();
    }
  }

  Future<void> _navigateToNextScreen() async {
    if (_isNavigating) return;
    _isNavigating = true;

    // if (NotificationService.isHandlingNotification) {
    //   debugPrint("Navigasi dibatalkan karena ada notifikasi.");
    //   return;
    // }

    final prefs = await SharedPreferences.getInstance();
    bool isSetupDone = prefs.getBool('isProtected') ?? false;

    Widget targetScreen = isSetupDone
        ? const LoginScreen()
        : const WelcomeScreen();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // From Bottom
            const end = Offset.zero;
            const curve = Curves.easeInOutQuart;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Centered Content (Mascot + Title)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_controller.value.isInitialized) ...{
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'MentorA',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: CustomColor.textBlue,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Teman Belajar kamu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: CustomColor.textBlue,
                      letterSpacing: -0.25,
                    ),
                  ),
                } else ...{
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.width * 0.95,
                  ),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}
