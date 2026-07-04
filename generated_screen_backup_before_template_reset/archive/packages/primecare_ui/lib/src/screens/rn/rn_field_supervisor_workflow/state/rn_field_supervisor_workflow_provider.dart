import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_field_supervisor_workflow_model.dart';

class RnFieldSupervisorWorkflowNotifier extends StateNotifier<RnFieldSupervisorWorkflowModel> {
  RnFieldSupervisorWorkflowNotifier() : super(const RnFieldSupervisorWorkflowModel(isLoading: true));

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

final rn_field_supervisor_workflowProvider = StateNotifierProvider<RnFieldSupervisorWorkflowNotifier, RnFieldSupervisorWorkflowModel>((ref) {
  return RnFieldSupervisorWorkflowNotifier()..loadData();
});
