// Governance - Category: view | Purpose: Coordinator layout for Hr Hiring Training Status
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringTrainingStatusScreen extends ConsumerWidget {
  const HrHiringTrainingStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Hr Hiring Training Status Coordinator'),
      ),
    );
  }
}
