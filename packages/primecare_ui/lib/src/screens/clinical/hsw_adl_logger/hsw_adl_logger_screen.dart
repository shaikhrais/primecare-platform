// Governance - Category: view | Purpose: Coordinator layout for HswAdlLoggerScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswAdlLoggerScreen extends ConsumerWidget {
  const HswAdlLoggerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('HswAdlLoggerScreen Coordinator'),
      ),
    );
  }
}
