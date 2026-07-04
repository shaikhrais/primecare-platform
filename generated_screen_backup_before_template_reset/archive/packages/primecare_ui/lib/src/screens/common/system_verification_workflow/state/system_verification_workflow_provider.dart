import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_verification_workflow_model.dart';

class SystemVerificationWorkflowNotifier extends StateNotifier<SystemVerificationWorkflowModel> {
  SystemVerificationWorkflowNotifier() : super(const SystemVerificationWorkflowModel(isLoading: true));

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

final system_verification_workflowProvider = StateNotifierProvider<SystemVerificationWorkflowNotifier, SystemVerificationWorkflowModel>((ref) {
  return SystemVerificationWorkflowNotifier()..loadData();
});
