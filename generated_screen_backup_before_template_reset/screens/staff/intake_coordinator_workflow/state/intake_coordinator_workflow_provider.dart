import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_workflow_model.dart';

class IntakeCoordinatorWorkflowNotifier extends StateNotifier<IntakeCoordinatorWorkflowModel> {
  IntakeCoordinatorWorkflowNotifier() : super(const IntakeCoordinatorWorkflowModel(isLoading: true));

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

final intake_coordinator_workflowProvider = StateNotifierProvider<IntakeCoordinatorWorkflowNotifier, IntakeCoordinatorWorkflowModel>((ref) {
  return IntakeCoordinatorWorkflowNotifier()..loadData();
});
