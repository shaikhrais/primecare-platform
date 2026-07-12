import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_shifts_model.dart';

class SchedulerShiftsNotifier extends StateNotifier<SchedulerShiftsModel> {
  SchedulerShiftsNotifier() : super(const SchedulerShiftsModel(isLoading: true));

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

final scheduler_shiftsProvider = StateNotifierProvider<SchedulerShiftsNotifier, SchedulerShiftsModel>((ref) {
  return SchedulerShiftsNotifier()..loadData();
});
