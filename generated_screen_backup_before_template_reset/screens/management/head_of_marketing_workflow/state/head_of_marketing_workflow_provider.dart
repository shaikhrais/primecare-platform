import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_marketing_workflow_model.dart';

class HeadOfMarketingWorkflowNotifier extends StateNotifier<HeadOfMarketingWorkflowModel> {
  HeadOfMarketingWorkflowNotifier() : super(const HeadOfMarketingWorkflowModel(isLoading: true));

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

final head_of_marketing_workflowProvider = StateNotifierProvider<HeadOfMarketingWorkflowNotifier, HeadOfMarketingWorkflowModel>((ref) {
  return HeadOfMarketingWorkflowNotifier()..loadData();
});
