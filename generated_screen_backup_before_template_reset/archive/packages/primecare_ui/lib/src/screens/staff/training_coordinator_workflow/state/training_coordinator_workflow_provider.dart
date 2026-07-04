import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_coordinator_workflow_model.dart';

class TrainingCoordinatorWorkflowNotifier extends StateNotifier<TrainingCoordinatorWorkflowModel> {
  TrainingCoordinatorWorkflowNotifier() : super(const TrainingCoordinatorWorkflowModel(isLoading: true));

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

final training_coordinator_workflowProvider = StateNotifierProvider<TrainingCoordinatorWorkflowNotifier, TrainingCoordinatorWorkflowModel>((ref) {
  return TrainingCoordinatorWorkflowNotifier()..loadData();
});
