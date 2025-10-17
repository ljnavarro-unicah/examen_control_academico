import 'package:flutter/material.dart';

class Course {
  final String id;
  final String name;
  // Optional ARGB color value (e.g. 0xFF4CAF50)
  final int? colorValue;

  double? p1;
  double? p2;
  double? p3;

  Course({
    required this.id,
    required this.name,
    this.colorValue,
    this.p1,
    this.p2,
    this.p3,
  });

  bool get hasAll =>
      p1 != null && p2 != null && p3 != null;

  double? get average {
    if (!hasAll) return null;
    return ((p1 ?? 0) + (p2 ?? 0) + (p3 ?? 0)) / 3.0;
  }

  /// Fraction of completed partials (0..1)
  double get completionFraction {
    final filled = [p1, p2, p3].where((e) => e != null).length;
    return filled / 3.0;
  }

  /// Normalized progress to show in UI (0..1). If average available, map average/100,
  /// otherwise show completionFraction.
  double get normalizedProgress {
    final avg = average;
    if (avg != null) return (avg.clamp(0, 100)) / 100.0;
    return completionFraction;
  }

  /// Returns a Flutter [Color] instance for the configured colorValue if present.
  Color? get color => colorValue != null ? Color(colorValue!) : null;

  String get category {
    final avg = average;
    if (avg == null) return 'Sin completar';
    if (avg >= 90) return 'Sobresaliente';
    if (avg >= 70) return 'Aprobado';
    return 'Reprobado';
  }
}