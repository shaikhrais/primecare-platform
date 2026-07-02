// Governance - Category: state | Purpose: Riverpod state notifier for Scheduler Coordinator Provider Availability
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCoordinatorProviderAvailabilityNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerCoordinatorProviderAvailabilityNotifier() : super(const AsyncValue.data(null));
}
