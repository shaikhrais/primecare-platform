import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_tasks_model.dart';

class RpnTasksNotifier extends StateNotifier<RpnTasksModel> {
  RpnTasksNotifier() : super(const RpnTasksModel(isLoading: true));

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

final rpn_tasksProvider = StateNotifierProvider<RpnTasksNotifier, RpnTasksModel>((ref) {
  return RpnTasksNotifier()..loadData();
});
