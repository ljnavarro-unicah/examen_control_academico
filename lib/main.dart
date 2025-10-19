import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/student.dart';
import 'models/course.dart';
import 'views/home_view.dart';

void main() {
  runApp(const AcademicApp());
}

class AcademicApp extends StatelessWidget {
  const AcademicApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF6750A4);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Control Académico',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 132, 113, 186),
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
          fillColor: Color.fromARGB(255, 163, 163, 165),
        ),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: HomeView(
        student: Student(
          name: 'Luis Enrique',
          photoPath: 'https://i.redd.it/ppq5lbv5o6ad1.png',
          courses: [
            Course(id: '1', name: 'Programación Móvil II'),
            Course(id: '2', name: 'Seminario de Hardware y Electricidad'),
            Course(id: '3', name: 'Gestión de Proyectos Informáticos'),
            Course(id: '4', name: 'Auditoría de Sistemas de Información'),
          ],
        ),
      ),
    );
  }
}
