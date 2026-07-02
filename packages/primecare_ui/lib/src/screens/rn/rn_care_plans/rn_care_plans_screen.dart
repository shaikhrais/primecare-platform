// Governance - Category: view | Purpose: Coordinator layout for RnCarePlansScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnCarePlansScreen extends ConsumerWidget {
  const RnCarePlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('RnCarePlansScreen Coordinator'),
      ),
    );
  }
}
