import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/failed_workflow_model.dart';

class FailedWorkflowNotifier extends StateNotifier<FailedWorkflowModel> {
  FailedWorkflowNotifier() : super(const FailedWorkflowModel(isLoading: true));

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

final failed_workflowProvider = StateNotifierProvider<FailedWorkflowNotifier, FailedWorkflowModel>((ref) {
  return FailedWorkflowNotifier()..loadData();
});
