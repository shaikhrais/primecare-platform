// Governance - Category: view | Purpose: Coordinator layout for Remote Patient Monitoring Dashboard
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemotePatientMonitoringDashboardScreen extends ConsumerWidget {
  const RemotePatientMonitoringDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Remote Patient Monitoring Dashboard Coordinator'),
      ),
    );
  }
}
