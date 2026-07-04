import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chiropractor_workflow_model.dart';

class ChiropractorWorkflowNotifier extends StateNotifier<ChiropractorWorkflowModel> {
  ChiropractorWorkflowNotifier() : super(const ChiropractorWorkflowModel(isLoading: true));

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

final chiropractor_workflowProvider = StateNotifierProvider<ChiropractorWorkflowNotifier, ChiropractorWorkflowModel>((ref) {
  return ChiropractorWorkflowNotifier()..loadData();
});
