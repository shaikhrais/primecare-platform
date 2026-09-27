// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerProviderAvailabilityScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerProviderAvailabilityNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerProviderAvailabilityNotifier() : super(const AsyncValue.data(null));
}
