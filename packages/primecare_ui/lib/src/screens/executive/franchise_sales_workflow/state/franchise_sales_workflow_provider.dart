import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_sales_workflow_model.dart';

class FranchiseSalesWorkflowNotifier extends StateNotifier<FranchiseSalesWorkflowModel> {
  FranchiseSalesWorkflowNotifier() : super(const FranchiseSalesWorkflowModel(isLoading: true));

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

final franchise_sales_workflowProvider = StateNotifierProvider<FranchiseSalesWorkflowNotifier, FranchiseSalesWorkflowModel>((ref) {
  return FranchiseSalesWorkflowNotifier()..loadData();
});
