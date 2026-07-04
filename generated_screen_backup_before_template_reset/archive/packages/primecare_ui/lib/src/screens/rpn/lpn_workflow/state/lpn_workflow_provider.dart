import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lpn_workflow_model.dart';

class LpnWorkflowNotifier extends StateNotifier<LpnWorkflowModel> {
  LpnWorkflowNotifier() : super(const LpnWorkflowModel(isLoading: true));

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

final lpn_workflowProvider = StateNotifierProvider<LpnWorkflowNotifier, LpnWorkflowModel>((ref) {
  return LpnWorkflowNotifier()..loadData();
});
