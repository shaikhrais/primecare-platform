// Governance - Category: view | Purpose: Coordinator layout for RnVitalsScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnVitalsScreen extends ConsumerWidget {
  const RnVitalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('RnVitalsScreen Coordinator'),
      ),
    );
  }
}
