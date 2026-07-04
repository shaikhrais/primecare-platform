import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinic_workflow_model.dart';

class ClinicWorkflowNotifier extends StateNotifier<ClinicWorkflowModel> {
  ClinicWorkflowNotifier() : super(const ClinicWorkflowModel(isLoading: true));

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

final clinic_workflowProvider = StateNotifierProvider<ClinicWorkflowNotifier, ClinicWorkflowModel>((ref) {
  return ClinicWorkflowNotifier()..loadData();
});
