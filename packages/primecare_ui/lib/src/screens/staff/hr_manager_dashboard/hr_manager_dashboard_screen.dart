// Governance - Category: view | Purpose: Coordinator layout for HrManagerDashboardScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerDashboardScreen extends ConsumerWidget {
  const HrManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('HrManagerDashboardScreen Coordinator'),
      ),
    );
  }
}
