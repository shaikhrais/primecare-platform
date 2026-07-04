import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/local_marketing_manager_workflow_model.dart';

class LocalMarketingManagerWorkflowNotifier extends StateNotifier<LocalMarketingManagerWorkflowModel> {
  LocalMarketingManagerWorkflowNotifier() : super(const LocalMarketingManagerWorkflowModel(isLoading: true));

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

final local_marketing_manager_workflowProvider = StateNotifierProvider<LocalMarketingManagerWorkflowNotifier, LocalMarketingManagerWorkflowModel>((ref) {
  return LocalMarketingManagerWorkflowNotifier()..loadData();
});
