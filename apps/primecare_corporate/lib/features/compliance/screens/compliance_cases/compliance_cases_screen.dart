// Governance - Category: view | Purpose: Coordinator layout for Compliance Cases
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceCasesScreen extends ConsumerWidget {
  const ComplianceCasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Compliance Cases Coordinator'),
      ),
    );
  }
}
