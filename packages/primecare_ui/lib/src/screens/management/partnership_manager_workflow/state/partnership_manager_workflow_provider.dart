import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/partnership_manager_workflow_model.dart';

class PartnershipManagerWorkflowNotifier extends StateNotifier<PartnershipManagerWorkflowModel> {
  PartnershipManagerWorkflowNotifier() : super(const PartnershipManagerWorkflowModel(isLoading: true));

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

final partnership_manager_workflowProvider = StateNotifierProvider<PartnershipManagerWorkflowNotifier, PartnershipManagerWorkflowModel>((ref) {
  return PartnershipManagerWorkflowNotifier()..loadData();
});
