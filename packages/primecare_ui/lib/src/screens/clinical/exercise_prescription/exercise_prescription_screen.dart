// Governance - Category: view | Purpose: Coordinator layout for ExercisePrescriptionScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExercisePrescriptionScreen extends ConsumerWidget {
  const ExercisePrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('ExercisePrescriptionScreen Coordinator'),
      ),
    );
  }
}
