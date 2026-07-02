// Governance - Category: view | Purpose: Coordinator layout for Training Coordinator Courses
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorCoursesScreen extends ConsumerWidget {
  const TrainingCoordinatorCoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Training Coordinator Courses Coordinator'),
      ),
    );
  }
}
