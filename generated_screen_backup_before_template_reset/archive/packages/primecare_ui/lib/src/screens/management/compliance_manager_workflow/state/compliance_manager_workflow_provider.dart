import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_workflow_model.dart';

class ComplianceManagerWorkflowNotifier extends StateNotifier<ComplianceManagerWorkflowModel> {
  ComplianceManagerWorkflowNotifier() : super(const ComplianceManagerWorkflowModel(isLoading: true));

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

final compliance_manager_workflowProvider = StateNotifierProvider<ComplianceManagerWorkflowNotifier, ComplianceManagerWorkflowModel>((ref) {
  return ComplianceManagerWorkflowNotifier()..loadData();
});
