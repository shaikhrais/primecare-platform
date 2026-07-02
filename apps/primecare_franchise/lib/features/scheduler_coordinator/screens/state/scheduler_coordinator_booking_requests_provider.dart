// Governance - Category: state | Purpose: Riverpod state notifier for Scheduler Coordinator Booking Requests
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCoordinatorBookingRequestsNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerCoordinatorBookingRequestsNotifier() : super(const AsyncValue.data(null));
}
