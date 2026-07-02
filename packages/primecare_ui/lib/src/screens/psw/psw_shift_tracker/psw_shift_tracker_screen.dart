// Governance - Category: view | Purpose: Coordinator layout for Shift Tracker
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswShiftTrackerScreen extends ConsumerWidget {
  const PswShiftTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Shift Tracker Coordinator'),
      ),
    );
  }
}
