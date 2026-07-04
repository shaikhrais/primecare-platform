import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_schedule_model.dart';

class OperationsManagerScheduleNotifier extends StateNotifier<OperationsManagerScheduleModel> {
  OperationsManagerScheduleNotifier() : super(const OperationsManagerScheduleModel(isLoading: true));

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

final operations_manager_scheduleProvider = StateNotifierProvider<OperationsManagerScheduleNotifier, OperationsManagerScheduleModel>((ref) {
  return OperationsManagerScheduleNotifier()..loadData();
});
