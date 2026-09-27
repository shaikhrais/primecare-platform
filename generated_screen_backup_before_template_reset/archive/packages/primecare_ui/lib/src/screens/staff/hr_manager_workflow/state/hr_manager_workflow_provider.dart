import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_manager_workflow_model.dart';

class HrManagerWorkflowNotifier extends StateNotifier<HrManagerWorkflowModel> {
  HrManagerWorkflowNotifier() : super(const HrManagerWorkflowModel(isLoading: true));

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

final hr_manager_workflowProvider = StateNotifierProvider<HrManagerWorkflowNotifier, HrManagerWorkflowModel>((ref) {
  return HrManagerWorkflowNotifier()..loadData();
});
