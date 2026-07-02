// Governance - Category: view | Purpose: Coordinator layout for GeneralManagerDashboardScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerDashboardScreen extends ConsumerWidget {
  const GeneralManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('GeneralManagerDashboardScreen Coordinator'),
      ),
    );
  }
}
