// Governance - Category: view | Purpose: Coordinator layout for Intake Coordinator Reports
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorReportsScreen extends ConsumerWidget {
  const IntakeCoordinatorReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Intake Coordinator Reports Coordinator'),
      ),
    );
  }
}
