import 'course.dart';

class Student {
  final String name;
  final List<Course> courses;

  Student({required this.name, required this.courses});

  double? get overallAverage {
    final avgs = courses.map((c) => c.average).where((a) => a != null).cast<double>().toList();
    if (avgs.isEmpty) return null;
    return avgs.reduce((a, b) => a + b) / avgs.length;
  }

  String get overallCategory {
    final avg = overallAverage;
    if (avg == null) return 'Sin completar';
    if (avg >= 90) return 'Sobresaliente';
    if (avg >= 70) return 'Aprobado';
    return 'Reprobado';
  }
}
