// Governance - Category: view | Purpose: Coordinator layout for HeadOfBusDevDashboardScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevDashboardScreen extends ConsumerWidget {
  const HeadOfBusDevDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('HeadOfBusDevDashboardScreen Coordinator'),
      ),
    );
  }
}
