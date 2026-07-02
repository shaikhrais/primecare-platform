// Governance - Category: view | Purpose: Coordinator layout for NursingTaskScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NursingTaskScreen extends ConsumerWidget {
  const NursingTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('NursingTaskScreen Coordinator'),
      ),
    );
  }
}
