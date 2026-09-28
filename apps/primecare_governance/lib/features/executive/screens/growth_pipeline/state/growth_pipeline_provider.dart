import 'package:flutter_riverpod/legacy.dart';
import '../models/growth_pipeline_model.dart';

class GrowthPipelineNotifier extends StateNotifier<GrowthPipelineModel> {
  GrowthPipelineNotifier() : super(const GrowthPipelineModel(isLoading: true));

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

final growth_pipelineProvider = StateNotifierProvider<GrowthPipelineNotifier, GrowthPipelineModel>((ref) {
  return GrowthPipelineNotifier()..loadData();
});
