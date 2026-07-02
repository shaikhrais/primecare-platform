// Governance - Category: view | Purpose: Coordinator layout for Therapist Compliance Workflow
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistWorkflowScreen extends ConsumerWidget {
  const TherapistWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Therapist Compliance Workflow Coordinator'),
      ),
    );
  }
}
