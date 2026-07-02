// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerDashboardNotifier() : super(const AsyncValue.data(null));
}
