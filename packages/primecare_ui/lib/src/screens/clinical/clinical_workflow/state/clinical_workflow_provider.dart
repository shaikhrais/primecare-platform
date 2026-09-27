import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_workflow_model.dart';

class ClinicalWorkflowNotifier extends StateNotifier<ClinicalWorkflowModel> {
  ClinicalWorkflowNotifier() : super(const ClinicalWorkflowModel(isLoading: true));

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

final clinical_workflowProvider = StateNotifierProvider<ClinicalWorkflowNotifier, ClinicalWorkflowModel>((ref) {
  return ClinicalWorkflowNotifier()..loadData();
});
