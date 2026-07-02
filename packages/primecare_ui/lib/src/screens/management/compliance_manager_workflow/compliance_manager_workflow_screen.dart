// Governance - Category: view | Purpose: Coordinator layout for ComplianceManagerWorkflowScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerWorkflowScreen extends ConsumerWidget {
  const ComplianceManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('ComplianceManagerWorkflowScreen Coordinator'),
      ),
    );
  }
}
