// Governance - Category: state | Purpose: Riverpod state notifier for Scheduler Coordinator Shift Calendar
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCoordinatorShiftCalendarNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerCoordinatorShiftCalendarNotifier() : super(const AsyncValue.data(null));
}
