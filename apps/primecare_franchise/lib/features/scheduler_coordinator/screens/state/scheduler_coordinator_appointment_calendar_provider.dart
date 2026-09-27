// Governance - Category: state | Purpose: Riverpod state notifier for Scheduler Coordinator Appointment Calendar
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerCoordinatorAppointmentCalendarNotifier extends StateNotifier<AsyncValue<void>> {
  SchedulerCoordinatorAppointmentCalendarNotifier() : super(const AsyncValue.data(null));
}
