// Governance - Category: view | Purpose: Coordinator layout for InfrastructureWorkflowScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureWorkflowScreen extends ConsumerWidget {
  const InfrastructureWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('InfrastructureWorkflowScreen Coordinator'),
      ),
    );
  }
}
