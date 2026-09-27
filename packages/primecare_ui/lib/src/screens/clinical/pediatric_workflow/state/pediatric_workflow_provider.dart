import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pediatric_workflow_model.dart';

class PediatricWorkflowNotifier extends StateNotifier<PediatricWorkflowModel> {
  PediatricWorkflowNotifier() : super(const PediatricWorkflowModel(isLoading: true));

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

final pediatric_workflowProvider = StateNotifierProvider<PediatricWorkflowNotifier, PediatricWorkflowModel>((ref) {
  return PediatricWorkflowNotifier()..loadData();
});
