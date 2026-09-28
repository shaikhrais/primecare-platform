import 'package:flutter_riverpod/legacy.dart';
import '../models/coo_workflow_performance_model.dart';

class CooWorkflowPerformanceNotifier extends StateNotifier<CooWorkflowPerformanceModel> {
  CooWorkflowPerformanceNotifier() : super(const CooWorkflowPerformanceModel(isLoading: true));

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

final coo_workflow_performanceProvider = StateNotifierProvider<CooWorkflowPerformanceNotifier, CooWorkflowPerformanceModel>((ref) {
  return CooWorkflowPerformanceNotifier()..loadData();
});
