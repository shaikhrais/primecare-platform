// Governance - Category: view | Purpose: Coordinator layout for TrainingCoordinatorWorkflowScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorWorkflowScreen extends ConsumerWidget {
  const TrainingCoordinatorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('TrainingCoordinatorWorkflowScreen Coordinator'),
      ),
    );
  }
}
