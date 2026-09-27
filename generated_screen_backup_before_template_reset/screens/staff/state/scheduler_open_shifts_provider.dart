// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerOpenShiftsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerOpenShiftsNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerOpenShiftsNotifier() : super(const AsyncValue.data(null));
}
