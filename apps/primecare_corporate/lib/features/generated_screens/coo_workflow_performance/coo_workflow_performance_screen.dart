// Governance - Category: view | Purpose: Coordinator layout for Coo Workflow Performance
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooWorkflowPerformanceScreen extends ConsumerWidget {
  const CooWorkflowPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Coo Workflow Performance Coordinator'),
      ),
    );
  }
}
