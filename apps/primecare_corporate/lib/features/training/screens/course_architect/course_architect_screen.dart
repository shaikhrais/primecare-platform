// Governance - Category: view | Purpose: Coordinator layout for Course Architect
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectScreen extends ConsumerWidget {
  const CourseArchitectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Course Architect Coordinator'),
      ),
    );
  }
}
