import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/student.dart';
import 'models/course.dart';
import 'views/home_view.dart';

void main() {
  runApp(const AcademicApp());
}

class AcademicApp extends StatefulWidget {
  const AcademicApp({super.key});

  @override
  State<AcademicApp> createState() => _AcademicAppState();
}

class _AcademicAppState extends State<AcademicApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF6750A4);

    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
      textTheme: GoogleFonts.poppinsTextTheme(),
      cardTheme: const CardThemeData(
        elevation: 1,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF7F7FA),
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
    );

    final dark = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Control Académico',
      themeMode: _themeMode,
      theme: baseTheme,
      darkTheme: dark,
      home: HomeView(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
        student: Student(
          name: 'Edar Castillo',
          courses: [
            Course(id: '1', name: 'Programación Móvil II', colorValue: 0xFF7B61FF, p1: 85, p2: 90, p3: 88),
            Course(id: '2', name: 'Circuitos Lógicos', colorValue: 0xFF00A896, p1: 75, p2: 68),
            Course(id: '3', name: 'Programación de Portales Web II', colorValue: 0xFFFF7043, p1: 95, p2: 92, p3: 94),
          ],
        ),
      ),
    );
  }
}
