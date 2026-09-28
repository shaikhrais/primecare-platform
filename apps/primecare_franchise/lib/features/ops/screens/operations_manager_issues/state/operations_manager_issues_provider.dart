import 'package:flutter_riverpod/legacy.dart';
import '../models/operations_manager_issues_model.dart';

class OperationsManagerIssuesNotifier extends StateNotifier<OperationsManagerIssuesModel> {
  OperationsManagerIssuesNotifier() : super(const OperationsManagerIssuesModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final operations_manager_issuesProvider = StateNotifierProvider<OperationsManagerIssuesNotifier, OperationsManagerIssuesModel>((ref) {
  return OperationsManagerIssuesNotifier()..loadData();
});
