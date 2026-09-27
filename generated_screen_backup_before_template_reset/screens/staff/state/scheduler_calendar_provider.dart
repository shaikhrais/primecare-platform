// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerCalendarScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCalendarNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerCalendarNotifier() : super(const AsyncValue.data(null));
}
