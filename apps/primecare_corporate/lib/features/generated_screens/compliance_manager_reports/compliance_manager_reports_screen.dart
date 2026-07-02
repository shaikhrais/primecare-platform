// Governance - Category: view | Purpose: Coordinator layout for Compliance Manager Reports
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerReportsScreen extends ConsumerWidget {
  const ComplianceManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Compliance Manager Reports Coordinator'),
      ),
    );
  }
}
