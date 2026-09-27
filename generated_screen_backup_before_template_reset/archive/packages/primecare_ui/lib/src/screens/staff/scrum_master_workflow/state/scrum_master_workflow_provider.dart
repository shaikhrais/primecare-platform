import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scrum_master_workflow_model.dart';

class ScrumMasterWorkflowNotifier extends StateNotifier<ScrumMasterWorkflowModel> {
  ScrumMasterWorkflowNotifier() : super(const ScrumMasterWorkflowModel(isLoading: true));

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

final scrum_master_workflowProvider = StateNotifierProvider<ScrumMasterWorkflowNotifier, ScrumMasterWorkflowModel>((ref) {
  return ScrumMasterWorkflowNotifier()..loadData();
});
