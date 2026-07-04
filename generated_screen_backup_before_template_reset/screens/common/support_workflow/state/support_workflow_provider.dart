import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/support_workflow_model.dart';

class SupportWorkflowNotifier extends StateNotifier<SupportWorkflowModel> {
  SupportWorkflowNotifier() : super(const SupportWorkflowModel(isLoading: true));

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

final support_workflowProvider = StateNotifierProvider<SupportWorkflowNotifier, SupportWorkflowModel>((ref) {
  return SupportWorkflowNotifier()..loadData();
});
