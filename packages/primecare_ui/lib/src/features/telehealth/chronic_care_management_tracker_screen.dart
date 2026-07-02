// Governance - Category: view | Purpose: Coordinator layout for Chronic Care Management Tracker
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChronicCareManagementTrackerScreen extends ConsumerWidget {
  const ChronicCareManagementTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Chronic Care Management Tracker Coordinator'),
      ),
    );
  }
}
