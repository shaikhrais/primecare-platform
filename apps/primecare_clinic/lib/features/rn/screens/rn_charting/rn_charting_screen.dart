// Governance - Category: view | Purpose: Coordinator layout for Rn Charting
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnChartingScreen extends ConsumerWidget {
  const RnChartingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Rn Charting Coordinator'),
      ),
    );
  }
}
