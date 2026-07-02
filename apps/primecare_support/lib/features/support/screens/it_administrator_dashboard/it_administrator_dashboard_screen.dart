// Governance - Category: view | Purpose: Coordinator layout for It Administrator Dashboard
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItAdministratorDashboardScreen extends ConsumerWidget {
  const ItAdministratorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('It Administrator Dashboard Coordinator'),
      ),
    );
  }
}
