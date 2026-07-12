import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_workflow_model.dart';

class RnWorkflowNotifier extends StateNotifier<RnWorkflowModel> {
  RnWorkflowNotifier() : super(const RnWorkflowModel(isLoading: true));

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

final rn_workflowProvider = StateNotifierProvider<RnWorkflowNotifier, RnWorkflowModel>((ref) {
  return RnWorkflowNotifier()..loadData();
});
