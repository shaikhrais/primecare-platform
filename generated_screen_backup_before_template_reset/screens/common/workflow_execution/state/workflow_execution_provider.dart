import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workflow_execution_model.dart';

class WorkflowExecutionNotifier extends StateNotifier<WorkflowExecutionModel> {
  WorkflowExecutionNotifier() : super(const WorkflowExecutionModel(isLoading: true));

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

final workflow_executionProvider = StateNotifierProvider<WorkflowExecutionNotifier, WorkflowExecutionModel>((ref) {
  return WorkflowExecutionNotifier()..loadData();
});
