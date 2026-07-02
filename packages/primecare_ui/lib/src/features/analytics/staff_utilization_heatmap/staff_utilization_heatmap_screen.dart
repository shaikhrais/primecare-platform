// Governance - Category: view | Purpose: Coordinator layout for Staff Utilization Heatmap
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffUtilizationHeatmapScreen extends ConsumerWidget {
  const StaffUtilizationHeatmapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Staff Utilization Heatmap Coordinator'),
      ),
    );
  }
}
