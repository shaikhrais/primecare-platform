import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_task_list_model.dart';

class PswTaskListNotifier extends StateNotifier<PswTaskListModel> {
  PswTaskListNotifier() : super(const PswTaskListModel(isLoading: true));

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

final psw_task_listProvider = StateNotifierProvider<PswTaskListNotifier, PswTaskListModel>((ref) {
  return PswTaskListNotifier()..loadData();
});
