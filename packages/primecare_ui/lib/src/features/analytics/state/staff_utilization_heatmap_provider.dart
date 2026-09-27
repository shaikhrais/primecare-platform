import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Staff Utilization Heatmap
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffUtilizationHeatmapNotifier extends StateNotifier<AsyncValue<void>> {
  StaffUtilizationHeatmapNotifier() : super(const AsyncValue.data(null));
}
