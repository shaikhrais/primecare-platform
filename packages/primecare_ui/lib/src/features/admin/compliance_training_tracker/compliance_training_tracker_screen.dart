// Governance - Category: view | Purpose: Coordinator layout for Compliance Training Tracker
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceTrainingTrackerScreen extends ConsumerWidget {
  const ComplianceTrainingTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Compliance Training Tracker Coordinator'),
      ),
    );
  }
}
