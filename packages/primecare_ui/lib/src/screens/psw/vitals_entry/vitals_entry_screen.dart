// Governance - Category: view | Purpose: Coordinator layout for Vitals Entry
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsEntryScreen extends ConsumerWidget {
  const VitalsEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Vitals Entry Coordinator'),
      ),
    );
  }
}
