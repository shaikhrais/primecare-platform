import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/np_workflow_model.dart';

class NpWorkflowNotifier extends StateNotifier<NpWorkflowModel> {
  NpWorkflowNotifier() : super(const NpWorkflowModel(isLoading: true));

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

final np_workflowProvider = StateNotifierProvider<NpWorkflowNotifier, NpWorkflowModel>((ref) {
  return NpWorkflowNotifier()..loadData();
});
