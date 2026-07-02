// Governance - Category: view | Purpose: Coordinator layout for Training Reports
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingReportsScreen extends ConsumerWidget {
  const TrainingReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Training Reports Coordinator'),
      ),
    );
  }
}
