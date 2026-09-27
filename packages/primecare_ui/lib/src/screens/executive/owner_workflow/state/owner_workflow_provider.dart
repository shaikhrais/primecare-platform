import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/owner_workflow_model.dart';

class OwnerWorkflowNotifier extends StateNotifier<OwnerWorkflowModel> {
  OwnerWorkflowNotifier() : super(const OwnerWorkflowModel(isLoading: true));

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

final owner_workflowProvider = StateNotifierProvider<OwnerWorkflowNotifier, OwnerWorkflowModel>((ref) {
  return OwnerWorkflowNotifier()..loadData();
});
