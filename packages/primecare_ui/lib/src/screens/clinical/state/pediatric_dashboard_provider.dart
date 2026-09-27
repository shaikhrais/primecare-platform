import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PediatricDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PediatricDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  PediatricDashboardNotifier() : super(const AsyncValue.data(null));
}
