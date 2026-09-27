import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_hub_workflow_model.dart';

class TrainingHubWorkflowNotifier extends StateNotifier<TrainingHubWorkflowModel> {
  TrainingHubWorkflowNotifier() : super(const TrainingHubWorkflowModel(isLoading: true));

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

final training_hub_workflowProvider = StateNotifierProvider<TrainingHubWorkflowNotifier, TrainingHubWorkflowModel>((ref) {
  return TrainingHubWorkflowNotifier()..loadData();
});
