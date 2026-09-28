// Governance - Category: state | Purpose: Riverpod state notifier for Regional Performance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RegionalPerformanceNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalPerformanceNotifier() : super(const AsyncValue.data(null));
}
