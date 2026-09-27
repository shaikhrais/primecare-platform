import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Telehealth Quality Metrics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TelehealthQualityMetricsNotifier extends StateNotifier<AsyncValue<void>> {
  TelehealthQualityMetricsNotifier() : super(const AsyncValue.data(null));
}
