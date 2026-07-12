import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for StaffPerformanceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffPerformanceNotifier extends StateNotifier<AsyncValue<void>> {
  StaffPerformanceNotifier() : super(const AsyncValue.data(null));
}
