// Governance - Category: view | Purpose: Coordinator layout for HrHiringWorkflowScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringWorkflowScreen extends ConsumerWidget {
  const HrHiringWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('HrHiringWorkflowScreen Coordinator'),
      ),
    );
  }
}
