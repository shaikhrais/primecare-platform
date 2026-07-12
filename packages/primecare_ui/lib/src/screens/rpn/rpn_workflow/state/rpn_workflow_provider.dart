import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_workflow_model.dart';

class RpnWorkflowNotifier extends StateNotifier<RpnWorkflowModel> {
  RpnWorkflowNotifier() : super(const RpnWorkflowModel(isLoading: true));

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

final rpn_workflowProvider = StateNotifierProvider<RpnWorkflowNotifier, RpnWorkflowModel>((ref) {
  return RpnWorkflowNotifier()..loadData();
});
