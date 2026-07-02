// Governance - Category: view | Purpose: Coordinator layout for HrDirectorWorkflowScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorWorkflowScreen extends ConsumerWidget {
  const HrDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('HrDirectorWorkflowScreen Coordinator'),
      ),
    );
  }
}
