// Governance - Category: state | Purpose: Riverpod state notifier for SchedulingDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulingDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulingDashboardNotifier() : super(const AsyncValue.data(null));
}
