import 'package:flutter_riverpod/legacy.dart';
import '../models/scheduler_coordinator_shift_calendar_model.dart';

class SchedulerCoordinatorShiftCalendarNotifier extends StateNotifier<SchedulerCoordinatorShiftCalendarModel> {
  SchedulerCoordinatorShiftCalendarNotifier() : super(const SchedulerCoordinatorShiftCalendarModel(isLoading: true));

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

final scheduler_coordinator_shift_calendarProvider = StateNotifierProvider<SchedulerCoordinatorShiftCalendarNotifier, SchedulerCoordinatorShiftCalendarModel>((ref) {
  return SchedulerCoordinatorShiftCalendarNotifier()..loadData();
});
