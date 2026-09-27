// Governance - Category: view | Purpose: Coordinator layout for Telehealth Quality Metrics
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TelehealthQualityMetricsScreen extends ConsumerWidget {
  const TelehealthQualityMetricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Telehealth Quality Metrics Coordinator'),
      ),
    );
  }
}
