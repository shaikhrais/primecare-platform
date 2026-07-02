// Governance - Category: view | Purpose: Coordinator layout for RpnDashboardScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnDashboardScreen extends ConsumerWidget {
  const RpnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('RpnDashboardScreen Coordinator'),
      ),
    );
  }
}
