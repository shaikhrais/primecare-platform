import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workflow_issue_model.dart';

class WorkflowIssueNotifier extends StateNotifier<WorkflowIssueModel> {
  WorkflowIssueNotifier() : super(const WorkflowIssueModel(isLoading: true));

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

final workflow_issueProvider = StateNotifierProvider<WorkflowIssueNotifier, WorkflowIssueModel>((ref) {
  return WorkflowIssueNotifier()..loadData();
});
