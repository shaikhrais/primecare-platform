import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_director_workflow_model.dart';

class TrainingDirectorWorkflowNotifier extends StateNotifier<TrainingDirectorWorkflowModel> {
  TrainingDirectorWorkflowNotifier() : super(const TrainingDirectorWorkflowModel(isLoading: true));

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

final training_director_workflowProvider = StateNotifierProvider<TrainingDirectorWorkflowNotifier, TrainingDirectorWorkflowModel>((ref) {
  return TrainingDirectorWorkflowNotifier()..loadData();
});
