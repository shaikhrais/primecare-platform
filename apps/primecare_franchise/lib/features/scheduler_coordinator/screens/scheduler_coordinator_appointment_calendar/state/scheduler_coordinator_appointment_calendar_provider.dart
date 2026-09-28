import 'package:flutter_riverpod/legacy.dart';
import '../models/scheduler_coordinator_appointment_calendar_model.dart';

class SchedulerCoordinatorAppointmentCalendarNotifier extends StateNotifier<SchedulerCoordinatorAppointmentCalendarModel> {
  SchedulerCoordinatorAppointmentCalendarNotifier() : super(const SchedulerCoordinatorAppointmentCalendarModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final scheduler_coordinator_appointment_calendarProvider = StateNotifierProvider<SchedulerCoordinatorAppointmentCalendarNotifier, SchedulerCoordinatorAppointmentCalendarModel>((ref) {
  return SchedulerCoordinatorAppointmentCalendarNotifier()..loadData();
});
