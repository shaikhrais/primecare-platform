import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_workflow_model.dart';

class OperationsManagerWorkflowNotifier extends StateNotifier<OperationsManagerWorkflowModel> {
  OperationsManagerWorkflowNotifier() : super(const OperationsManagerWorkflowModel(isLoading: true));

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

final operations_manager_workflowProvider = StateNotifierProvider<OperationsManagerWorkflowNotifier, OperationsManagerWorkflowModel>((ref) {
  return OperationsManagerWorkflowNotifier()..loadData();
});
