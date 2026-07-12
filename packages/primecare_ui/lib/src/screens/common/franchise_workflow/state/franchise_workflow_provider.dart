import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_workflow_model.dart';

class FranchiseWorkflowNotifier extends StateNotifier<FranchiseWorkflowModel> {
  FranchiseWorkflowNotifier() : super(const FranchiseWorkflowModel(isLoading: true));

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

final franchise_workflowProvider = StateNotifierProvider<FranchiseWorkflowNotifier, FranchiseWorkflowModel>((ref) {
  return FranchiseWorkflowNotifier()..loadData();
});
