// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Director Quality Metrics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ClinicalDirectorQualityMetricsNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalDirectorQualityMetricsNotifier() : super(const AsyncValue.data(null));
}
