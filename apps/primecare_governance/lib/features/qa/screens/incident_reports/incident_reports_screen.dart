// Governance - Category: view | Purpose: Coordinator layout for Incident Reports
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentReportsScreen extends ConsumerWidget {
  const IncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Incident Reports Coordinator'),
      ),
    );
  }
}
