// Governance - Category: view | Purpose: Coordinator layout for RpnReportsScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnReportsScreen extends ConsumerWidget {
  const RpnReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('RpnReportsScreen Coordinator'),
      ),
    );
  }
}
