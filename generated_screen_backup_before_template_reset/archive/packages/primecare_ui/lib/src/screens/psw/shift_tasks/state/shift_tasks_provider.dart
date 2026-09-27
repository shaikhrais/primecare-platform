import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shift_tasks_model.dart';

class ShiftTasksNotifier extends StateNotifier<ShiftTasksModel> {
  ShiftTasksNotifier() : super(const ShiftTasksModel(isLoading: true));

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

final shift_tasksProvider = StateNotifierProvider<ShiftTasksNotifier, ShiftTasksModel>((ref) {
  return ShiftTasksNotifier()..loadData();
});
