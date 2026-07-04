import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_workflow_model.dart';

class PatientWorkflowNotifier extends StateNotifier<PatientWorkflowModel> {
  PatientWorkflowNotifier() : super(const PatientWorkflowModel(isLoading: true));

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

final patient_workflowProvider = StateNotifierProvider<PatientWorkflowNotifier, PatientWorkflowModel>((ref) {
  return PatientWorkflowNotifier()..loadData();
});
