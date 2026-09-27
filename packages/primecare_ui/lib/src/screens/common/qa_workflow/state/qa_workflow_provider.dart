import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/qa_workflow_model.dart';

class QaWorkflowNotifier extends StateNotifier<QaWorkflowModel> {
  QaWorkflowNotifier() : super(const QaWorkflowModel(isLoading: true));

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

final qa_workflowProvider = StateNotifierProvider<QaWorkflowNotifier, QaWorkflowModel>((ref) {
  return QaWorkflowNotifier()..loadData();
});
