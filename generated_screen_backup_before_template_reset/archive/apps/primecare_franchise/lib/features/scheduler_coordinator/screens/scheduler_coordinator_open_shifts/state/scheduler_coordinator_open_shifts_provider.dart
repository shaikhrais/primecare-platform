import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_coordinator_open_shifts_model.dart';

class SchedulerCoordinatorOpenShiftsNotifier extends StateNotifier<SchedulerCoordinatorOpenShiftsModel> {
  SchedulerCoordinatorOpenShiftsNotifier() : super(const SchedulerCoordinatorOpenShiftsModel(isLoading: true));

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

final scheduler_coordinator_open_shiftsProvider = StateNotifierProvider<SchedulerCoordinatorOpenShiftsNotifier, SchedulerCoordinatorOpenShiftsModel>((ref) {
  return SchedulerCoordinatorOpenShiftsNotifier()..loadData();
});
