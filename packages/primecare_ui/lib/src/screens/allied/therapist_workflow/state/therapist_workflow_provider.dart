import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/therapist_workflow_model.dart';

class TherapistWorkflowNotifier extends StateNotifier<TherapistWorkflowModel> {
  TherapistWorkflowNotifier() : super(const TherapistWorkflowModel(isLoading: true));

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

final therapist_workflowProvider = StateNotifierProvider<TherapistWorkflowNotifier, TherapistWorkflowModel>((ref) {
  return TherapistWorkflowNotifier()..loadData();
});
