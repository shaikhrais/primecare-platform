import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_manager_workflow_model.dart';

class FranchiseSalesManagerWorkflowNotifier extends StateNotifier<FranchiseSalesManagerWorkflowModel> {
  FranchiseSalesManagerWorkflowNotifier() : super(const FranchiseSalesManagerWorkflowModel(isLoading: true));

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

final franchise_sales_manager_workflowProvider = StateNotifierProvider<FranchiseSalesManagerWorkflowNotifier, FranchiseSalesManagerWorkflowModel>((ref) {
  return FranchiseSalesManagerWorkflowNotifier()..loadData();
});
