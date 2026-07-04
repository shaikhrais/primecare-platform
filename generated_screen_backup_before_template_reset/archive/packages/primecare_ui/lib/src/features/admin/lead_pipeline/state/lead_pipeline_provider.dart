import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lead_pipeline_model.dart';

class LeadPipelineNotifier extends StateNotifier<LeadPipelineModel> {
  LeadPipelineNotifier() : super(const LeadPipelineModel(isLoading: true));

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

final lead_pipelineProvider = StateNotifierProvider<LeadPipelineNotifier, LeadPipelineModel>((ref) {
  return LeadPipelineNotifier()..loadData();
});
