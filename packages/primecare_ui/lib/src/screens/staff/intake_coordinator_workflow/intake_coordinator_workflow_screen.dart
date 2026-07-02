// Governance - Category: view | Purpose: Coordinator layout for IntakeCoordinatorWorkflowScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorWorkflowScreen extends ConsumerWidget {
  const IntakeCoordinatorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('IntakeCoordinatorWorkflowScreen Coordinator'),
      ),
    );
  }
}
