import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_calendar_model.dart';

class SchedulerCalendarNotifier extends StateNotifier<SchedulerCalendarModel> {
  SchedulerCalendarNotifier() : super(const SchedulerCalendarModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final scheduler_calendarProvider = StateNotifierProvider<SchedulerCalendarNotifier, SchedulerCalendarModel>((ref) {
  return SchedulerCalendarNotifier()..loadData();
});
