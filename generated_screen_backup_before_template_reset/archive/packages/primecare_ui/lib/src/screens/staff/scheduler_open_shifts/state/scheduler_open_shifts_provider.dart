import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_open_shifts_model.dart';

class SchedulerOpenShiftsNotifier extends StateNotifier<SchedulerOpenShiftsModel> {
  SchedulerOpenShiftsNotifier() : super(const SchedulerOpenShiftsModel(isLoading: true));

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

final scheduler_open_shiftsProvider = StateNotifierProvider<SchedulerOpenShiftsNotifier, SchedulerOpenShiftsModel>((ref) {
  return SchedulerOpenShiftsNotifier()..loadData();
});
