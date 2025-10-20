class Course {
  final String id;
  final String name;

  double? p1;
  double? p2;
  double? p3;
  double? p4;

  Course({
    required this.id,
    required this.name,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
  });

  bool get hasAll => p1 != null && p2 != null && p3 != null && p4 != null;

  double? get average {
    if (!hasAll) return null;
    return ((p1 ?? 0) + (p2 ?? 0) + (p3 ?? 0) + (p4 ?? 0)) / 3.0;
  }

  String get category {
    final avg = average;
    if (avg == null) return 'Sin completar';
    if (avg >= 90) return 'Sobresaliente';
    if (avg >= 70) return 'Aprobado';
    return 'Reprobado';
  }
}
