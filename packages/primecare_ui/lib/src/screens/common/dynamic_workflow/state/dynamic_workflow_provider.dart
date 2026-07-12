import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dynamic_workflow_model.dart';

class DynamicWorkflowNotifier extends StateNotifier<DynamicWorkflowModel> {
  DynamicWorkflowNotifier() : super(const DynamicWorkflowModel(isLoading: true));

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

final dynamic_workflowProvider = StateNotifierProvider<DynamicWorkflowNotifier, DynamicWorkflowModel>((ref) {
  return DynamicWorkflowNotifier()..loadData();
});
