import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/portal_workflow_model.dart';

class PortalWorkflowNotifier extends StateNotifier<PortalWorkflowModel> {
  PortalWorkflowNotifier() : super(const PortalWorkflowModel(isLoading: true));

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

final portal_workflowProvider = StateNotifierProvider<PortalWorkflowNotifier, PortalWorkflowModel>((ref) {
  return PortalWorkflowNotifier()..loadData();
});
