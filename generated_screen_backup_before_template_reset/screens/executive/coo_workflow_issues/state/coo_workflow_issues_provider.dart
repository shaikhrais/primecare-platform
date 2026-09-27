import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coo_workflow_issues_model.dart';

class CooWorkflowIssuesNotifier extends StateNotifier<CooWorkflowIssuesModel> {
  CooWorkflowIssuesNotifier() : super(const CooWorkflowIssuesModel(isLoading: true));

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

final coo_workflow_issuesProvider = StateNotifierProvider<CooWorkflowIssuesNotifier, CooWorkflowIssuesModel>((ref) {
  return CooWorkflowIssuesNotifier()..loadData();
});
