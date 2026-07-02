// Governance - Category: view | Purpose: Coordinator layout for AppointmentOverviewScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentOverviewScreen extends ConsumerWidget {
  const AppointmentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('AppointmentOverviewScreen Coordinator'),
      ),
    );
  }
}
