// Governance - Category: state | Purpose: Riverpod state notifier for Quality Metrics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class QualityMetricsNotifier extends StateNotifier<AsyncValue<void>> {
  QualityMetricsNotifier() : super(const AsyncValue.data(null));
}
