import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mentor_a/screen/splash_secreen.dart';
import 'package:mentor_a/screen/student/home_student_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D7BD9)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      locale: Locale('id', 'ID'),
      home: const HomeStudentScreen(),
    );
  }
}
