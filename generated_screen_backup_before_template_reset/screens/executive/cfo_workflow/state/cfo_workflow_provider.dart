import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_workflow_model.dart';

class CfoWorkflowNotifier extends StateNotifier<CfoWorkflowModel> {
  CfoWorkflowNotifier() : super(const CfoWorkflowModel(isLoading: true));

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

final cfo_workflowProvider = StateNotifierProvider<CfoWorkflowNotifier, CfoWorkflowModel>((ref) {
  return CfoWorkflowNotifier()..loadData();
});
