// Governance - Category: view | Purpose: Coordinator layout for Outpatient Prescription Tracker
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutpatientPrescriptionTrackerScreen extends ConsumerWidget {
  const OutpatientPrescriptionTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Outpatient Prescription Tracker Coordinator'),
      ),
    );
  }
}
