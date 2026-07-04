import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/general_manager_workflow_model.dart';

class GeneralManagerWorkflowNotifier extends StateNotifier<GeneralManagerWorkflowModel> {
  GeneralManagerWorkflowNotifier() : super(const GeneralManagerWorkflowModel(isLoading: true));

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

final general_manager_workflowProvider = StateNotifierProvider<GeneralManagerWorkflowNotifier, GeneralManagerWorkflowModel>((ref) {
  return GeneralManagerWorkflowNotifier()..loadData();
});
