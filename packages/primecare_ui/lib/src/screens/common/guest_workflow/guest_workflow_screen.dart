// Governance - Category: view | Purpose: Coordinator layout for GuestWorkflowScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestWorkflowScreen extends ConsumerWidget {
  const GuestWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('GuestWorkflowScreen Coordinator'),
      ),
    );
  }
}
