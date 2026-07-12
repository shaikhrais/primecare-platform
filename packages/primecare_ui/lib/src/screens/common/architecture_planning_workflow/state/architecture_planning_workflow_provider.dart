import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/architecture_planning_workflow_model.dart';

class ArchitecturePlanningWorkflowNotifier extends StateNotifier<ArchitecturePlanningWorkflowModel> {
  ArchitecturePlanningWorkflowNotifier() : super(const ArchitecturePlanningWorkflowModel(isLoading: true));

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

final architecture_planning_workflowProvider = StateNotifierProvider<ArchitecturePlanningWorkflowNotifier, ArchitecturePlanningWorkflowModel>((ref) {
  return ArchitecturePlanningWorkflowNotifier()..loadData();
});
