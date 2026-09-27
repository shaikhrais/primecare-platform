import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ceo_growth_pipeline_model.dart';

class CeoGrowthPipelineNotifier extends StateNotifier<CeoGrowthPipelineModel> {
  CeoGrowthPipelineNotifier() : super(const CeoGrowthPipelineModel(isLoading: true));

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

final ceo_growth_pipelineProvider = StateNotifierProvider<CeoGrowthPipelineNotifier, CeoGrowthPipelineModel>((ref) {
  return CeoGrowthPipelineNotifier()..loadData();
});
