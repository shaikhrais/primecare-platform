import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scheduler_workflow_model.dart';

class SchedulerWorkflowNotifier extends StateNotifier<SchedulerWorkflowModel> {
  SchedulerWorkflowNotifier() : super(const SchedulerWorkflowModel(isLoading: true));

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

final scheduler_workflowProvider = StateNotifierProvider<SchedulerWorkflowNotifier, SchedulerWorkflowModel>((ref) {
  return SchedulerWorkflowNotifier()..loadData();
});
