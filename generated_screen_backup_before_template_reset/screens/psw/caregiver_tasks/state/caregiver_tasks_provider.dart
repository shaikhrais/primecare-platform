import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caregiver_tasks_model.dart';

class CaregiverTasksNotifier extends StateNotifier<CaregiverTasksModel> {
  CaregiverTasksNotifier() : super(const CaregiverTasksModel(isLoading: true));

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

final caregiver_tasksProvider = StateNotifierProvider<CaregiverTasksNotifier, CaregiverTasksModel>((ref) {
  return CaregiverTasksNotifier()..loadData();
});
