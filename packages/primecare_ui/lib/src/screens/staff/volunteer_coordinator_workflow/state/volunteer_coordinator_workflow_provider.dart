import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/volunteer_coordinator_workflow_model.dart';

class VolunteerCoordinatorWorkflowNotifier extends StateNotifier<VolunteerCoordinatorWorkflowModel> {
  VolunteerCoordinatorWorkflowNotifier() : super(const VolunteerCoordinatorWorkflowModel(isLoading: true));

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

final volunteer_coordinator_workflowProvider = StateNotifierProvider<VolunteerCoordinatorWorkflowNotifier, VolunteerCoordinatorWorkflowModel>((ref) {
  return VolunteerCoordinatorWorkflowNotifier()..loadData();
});
