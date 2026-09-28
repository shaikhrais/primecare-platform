// Governance - Category: state | Purpose: Riverpod state notifier for Scheduler Coordinator Open Shifts
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SchedulerCoordinatorOpenShiftsNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerCoordinatorOpenShiftsNotifier() : super(const AsyncValue.data(null));
}
