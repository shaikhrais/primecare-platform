import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Operational Efficiency Metrics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationalEfficiencyMetricsNotifier extends StateNotifier<AsyncValue<void>> {
  OperationalEfficiencyMetricsNotifier() : super(const AsyncValue.data(null));
}
