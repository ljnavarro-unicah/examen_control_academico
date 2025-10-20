import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailView extends StatefulWidget {
  final Course course;

  const CourseDetailView({super.key, required this.course});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _p1Ctrl;
  late final TextEditingController _p2Ctrl;
  late final TextEditingController _p3Ctrl;
  late final TextEditingController _p4Ctrl;

  @override
  void initState() {
    super.initState();
    _p1Ctrl = TextEditingController(text: _fmt(widget.course.p1));
    _p2Ctrl = TextEditingController(text: _fmt(widget.course.p2));
    _p3Ctrl = TextEditingController(text: _fmt(widget.course.p3));
    _p4Ctrl = TextEditingController(text: _fmt(widget.course.p4));
  }

  String _fmt(double? v) =>
      v == null ? '' : v.toStringAsFixed(v % 1 == 0 ? 0 : 2);

  @override
  void dispose() {
    _p1Ctrl.dispose();
    _p2Ctrl.dispose();
    _p3Ctrl.dispose();
    _p4Ctrl.dispose();
    super.dispose();
  }

  String? _validate(String? v) {
    if (v == null || v.trim().isEmpty) return 'Requerido';
    final num? n = num.tryParse(v);
    if (n == null) return 'Número inválido';
    if (n < 0 || n > 100) return '0 - 100';
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    widget.course
      ..p1 = double.parse(_p1Ctrl.text)
      ..p2 = double.parse(_p2Ctrl.text)
      ..p3 = double.parse(_p3Ctrl.text);
    Navigator.of(context).pop(widget.course);
  }

  @override
  Widget build(BuildContext context) {
    final avg = widget.course.average;
    final cat = widget.course.category;

    return Scaffold(
      appBar: AppBar(title: Text(widget.course.name), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _HeaderBadge(avg: avg, category: cat),
            const SizedBox(height: 16),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _GradeField(
                        label: 'Parcial 1',
                        controller: _p1Ctrl,
                        validator: _validate,
                      ),
                      const SizedBox(height: 12),
                      _GradeField(
                        label: 'Parcial 2',
                        controller: _p2Ctrl,
                        validator: _validate,
                      ),
                      const SizedBox(height: 12),
                      _GradeField(
                        label: 'Parcial 3',
                        controller: _p3Ctrl,
                        validator: _validate,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _save,
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Guardar notas'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBadge extends StatelessWidget {
  final double? avg;
  final String category;

  const _HeaderBadge({required this.avg, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final secondary = theme.colorScheme.secondaryContainer;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondary, surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            child: Icon(
              Icons.assessment_outlined,
              size: 28,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Promedio actual',
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  avg == null ? '—' : avg!.toStringAsFixed(2),
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _CategoryChip(category: category),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String category;
  const _CategoryChip({required this.category});

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

    return Chip(
      label: Text(category),
      avatar: Icon(
        Icons.flag_outlined,
        size: 18,
        color: theme.colorScheme.onPrimary,
      ),
      backgroundColor: tone().withOpacity(0.1),
      labelStyle: theme.textTheme.labelLarge!.copyWith(
        color: tone(),
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(color: tone().withOpacity(0.4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class _GradeField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const _GradeField({
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        hintText: '0 a 100',
        prefixIcon: const Icon(Icons.edit_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
