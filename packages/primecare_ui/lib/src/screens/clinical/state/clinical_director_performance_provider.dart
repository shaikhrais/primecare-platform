import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ClinicalDirectorPerformanceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorPerformanceNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalDirectorPerformanceNotifier() : super(const AsyncValue.data(null));
}
