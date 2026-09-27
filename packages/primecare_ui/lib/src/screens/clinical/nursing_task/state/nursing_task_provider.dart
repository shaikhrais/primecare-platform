import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nursing_task_model.dart';

class NursingTaskNotifier extends StateNotifier<NursingTaskModel> {
  NursingTaskNotifier() : super(const NursingTaskModel(isLoading: true));

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

final nursing_taskProvider = StateNotifierProvider<NursingTaskNotifier, NursingTaskModel>((ref) {
  return NursingTaskNotifier()..loadData();
});
