import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/course.dart';
import 'course_detail_view.dart';

class HomeView extends StatefulWidget {
  final Student student;
  const HomeView({super.key, required this.student});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _openCourse(Course c) async {
    final updated = await Navigator.of(context).push<Course>(
      MaterialPageRoute(builder: (_) => CourseDetailView(course: c)),
    );
    if (updated != null) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avg = widget.student.overallAverage;
    final cat = widget.student.overallCategory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Control Académico'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.surface, theme.colorScheme.surfaceContainerHighest],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _HeaderCard(name: widget.student.name, overallAvg: avg, category: cat),
            const SizedBox(height: 16),
            Text('Mis clases', style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...widget.student.courses.map((c) => _CourseTile(course: c, onTap: () => _openCourse(c))),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String name;
  final double? overallAvg;
  final String category;
  const _HeaderCard({required this.name, required this.overallAvg, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundImage: null, 
              child: Text(
                _initials(name),
                style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star_outline, size: 18, color: theme.colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        'Promedio general: ${overallAvg == null ? '—' : overallAvg!.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 12),
                      _CategoryBadge(category: category),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _initials(String n) {
    final parts = n.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return '👤';
    if (parts.length == 1) return parts.first.characters.take(2).toString().toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first).toUpperCase();
  }
}

class _CourseTile extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const _CourseTile({required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avg = course.average;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        leading: CircleAvatar(
          radius: 22,
          child: Icon(Icons.menu_book_outlined, color: theme.colorScheme.onPrimaryContainer),
        ),
        title: Text(course.name, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(
          avg == null ? 'No hay promedio' : 'Promedio: ${avg.toStringAsFixed(2)}  ·  ${course.category}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: theme.colorScheme.outline),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color tone() {
      switch (category) {
        case 'Sobresaliente':
          return Colors.green;
        case 'Aprobado':
          return Colors.blue;
        case 'Reprobado':
          return Colors.red;
        default:
          return theme.colorScheme.outline;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tone().withOpacity(0.1),
        border: Border.all(color: tone().withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: theme.textTheme.labelMedium!.copyWith(color: tone(), fontWeight: FontWeight.w700),
      ),
    );
  }
}
