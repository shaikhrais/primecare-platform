// Governance - Category: view | Purpose: Coordinator layout for IntakeDashboardScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeDashboardScreen extends ConsumerWidget {
  const IntakeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('IntakeDashboardScreen Coordinator'),
      ),
    );
  }
}
