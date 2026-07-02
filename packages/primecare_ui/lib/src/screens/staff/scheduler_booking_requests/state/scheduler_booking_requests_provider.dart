// Governance - Category: state | Purpose: Riverpod state notifier for SchedulerBookingRequestsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerBookingRequestsNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerBookingRequestsNotifier() : super(const AsyncValue.data(null));
}
