import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_workflow_model.dart';

class SystemWorkflowNotifier extends StateNotifier<SystemWorkflowModel> {
  SystemWorkflowNotifier() : super(const SystemWorkflowModel(isLoading: true));

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

final system_workflowProvider = StateNotifierProvider<SystemWorkflowNotifier, SystemWorkflowModel>((ref) {
  return SystemWorkflowNotifier()..loadData();
});
