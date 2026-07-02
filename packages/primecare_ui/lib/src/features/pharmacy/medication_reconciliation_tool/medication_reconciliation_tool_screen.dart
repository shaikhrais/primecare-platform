// Governance - Category: view | Purpose: Coordinator layout for Medication Reconciliation Tool
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicationReconciliationToolScreen extends ConsumerWidget {
  const MedicationReconciliationToolScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Medication Reconciliation Tool Coordinator'),
      ),
    );
  }
}
