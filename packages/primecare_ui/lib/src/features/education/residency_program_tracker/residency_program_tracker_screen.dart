// Governance - Category: view | Purpose: Coordinator layout for Residency Program Tracker
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResidencyProgramTrackerScreen extends ConsumerWidget {
  const ResidencyProgramTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Residency Program Tracker Coordinator'),
      ),
    );
  }
}
