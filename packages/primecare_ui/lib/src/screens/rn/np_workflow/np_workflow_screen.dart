// Governance - Category: view | Purpose: Coordinator layout for Nurse Practitioner (NP) Compliance Workflow
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NpWorkflowScreen extends ConsumerWidget {
  const NpWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Nurse Practitioner (NP) Compliance Workflow Coordinator'),
      ),
    );
  }
}
