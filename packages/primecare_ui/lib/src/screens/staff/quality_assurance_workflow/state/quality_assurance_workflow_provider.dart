import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quality_assurance_workflow_model.dart';

class QualityAssuranceWorkflowNotifier extends StateNotifier<QualityAssuranceWorkflowModel> {
  QualityAssuranceWorkflowNotifier() : super(const QualityAssuranceWorkflowModel(isLoading: true));

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

final quality_assurance_workflowProvider = StateNotifierProvider<QualityAssuranceWorkflowNotifier, QualityAssuranceWorkflowModel>((ref) {
  return QualityAssuranceWorkflowNotifier()..loadData();
});
