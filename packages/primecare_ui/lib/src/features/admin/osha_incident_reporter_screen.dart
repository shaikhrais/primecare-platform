// Governance - Category: view | Purpose: Coordinator layout for Osha Incident Reporter
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OshaIncidentReporterScreen extends ConsumerWidget {
  const OshaIncidentReporterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Osha Incident Reporter Coordinator'),
      ),
    );
  }
}
