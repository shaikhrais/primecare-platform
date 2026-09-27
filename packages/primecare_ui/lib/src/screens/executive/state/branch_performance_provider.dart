import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for BranchPerformanceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BranchPerformanceNotifier extends StateNotifier<AsyncValue<void>> {
  BranchPerformanceNotifier() : super(const AsyncValue.data(null));
}
