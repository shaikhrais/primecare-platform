import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_tasks_model.dart';

class RegionalBdmTasksNotifier extends StateNotifier<RegionalBdmTasksModel> {
  RegionalBdmTasksNotifier() : super(const RegionalBdmTasksModel(isLoading: true));

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

final regional_bdm_tasksProvider = StateNotifierProvider<RegionalBdmTasksNotifier, RegionalBdmTasksModel>((ref) {
  return RegionalBdmTasksNotifier()..loadData();
});
