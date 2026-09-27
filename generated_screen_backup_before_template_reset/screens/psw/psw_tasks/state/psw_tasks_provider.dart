import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_tasks_model.dart';

class PswTasksNotifier extends StateNotifier<PswTasksModel> {
  PswTasksNotifier() : super(const PswTasksModel(isLoading: true));

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

final psw_tasksProvider = StateNotifierProvider<PswTasksNotifier, PswTasksModel>((ref) {
  return PswTasksNotifier()..loadData();
});
