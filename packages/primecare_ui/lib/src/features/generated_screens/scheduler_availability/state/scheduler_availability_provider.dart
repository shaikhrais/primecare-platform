// Governance - Category: state | Purpose: Riverpod state notifier for Scheduler Availability
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerAvailabilityNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerAvailabilityNotifier() : super(const AsyncValue.data(null));
}
