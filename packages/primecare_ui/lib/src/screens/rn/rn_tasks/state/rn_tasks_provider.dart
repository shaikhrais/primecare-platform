import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_tasks_model.dart';

class RnTasksNotifier extends StateNotifier<RnTasksModel> {
  RnTasksNotifier() : super(const RnTasksModel(isLoading: true));

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

final rn_tasksProvider = StateNotifierProvider<RnTasksNotifier, RnTasksModel>((ref) {
  return RnTasksNotifier()..loadData();
});
