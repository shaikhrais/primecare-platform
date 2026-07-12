import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/governance_officer_workflow_model.dart';

class GovernanceOfficerWorkflowNotifier extends StateNotifier<GovernanceOfficerWorkflowModel> {
  GovernanceOfficerWorkflowNotifier() : super(const GovernanceOfficerWorkflowModel(isLoading: true));

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

final governance_officer_workflowProvider = StateNotifierProvider<GovernanceOfficerWorkflowNotifier, GovernanceOfficerWorkflowModel>((ref) {
  return GovernanceOfficerWorkflowNotifier()..loadData();
});
