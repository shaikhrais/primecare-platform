// Governance - Category: view | Purpose: Coordinator layout for HswScheduleScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswScheduleScreen extends ConsumerWidget {
  const HswScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('HswScheduleScreen Coordinator'),
      ),
    );
  }
}
