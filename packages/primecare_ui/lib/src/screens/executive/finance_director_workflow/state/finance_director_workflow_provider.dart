import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/finance_director_workflow_model.dart';

class FinanceDirectorWorkflowNotifier extends StateNotifier<FinanceDirectorWorkflowModel> {
  FinanceDirectorWorkflowNotifier() : super(const FinanceDirectorWorkflowModel(isLoading: true));

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

final finance_director_workflowProvider = StateNotifierProvider<FinanceDirectorWorkflowNotifier, FinanceDirectorWorkflowModel>((ref) {
  return FinanceDirectorWorkflowNotifier()..loadData();
});
