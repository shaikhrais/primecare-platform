// Governance - Category: view | Purpose: Coordinator layout for Intake Coordinator Assessments
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorAssessmentsScreen extends ConsumerWidget {
  const IntakeCoordinatorAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Intake Coordinator Assessments Coordinator'),
      ),
    );
  }
}
