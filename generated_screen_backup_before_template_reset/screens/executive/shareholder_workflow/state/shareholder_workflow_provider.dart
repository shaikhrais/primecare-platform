import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shareholder_workflow_model.dart';

class ShareholderWorkflowNotifier extends StateNotifier<ShareholderWorkflowModel> {
  ShareholderWorkflowNotifier() : super(const ShareholderWorkflowModel(isLoading: true));

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

final shareholder_workflowProvider = StateNotifierProvider<ShareholderWorkflowNotifier, ShareholderWorkflowModel>((ref) {
  return ShareholderWorkflowNotifier()..loadData();
});
