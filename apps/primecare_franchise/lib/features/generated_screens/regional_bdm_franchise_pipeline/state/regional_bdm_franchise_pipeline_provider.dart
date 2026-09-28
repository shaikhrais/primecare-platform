import 'package:flutter_riverpod/legacy.dart';
import '../models/regional_bdm_franchise_pipeline_model.dart';

class RegionalBdmFranchisePipelineNotifier extends StateNotifier<RegionalBdmFranchisePipelineModel> {
  RegionalBdmFranchisePipelineNotifier() : super(const RegionalBdmFranchisePipelineModel(isLoading: true));

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

final regional_bdm_franchise_pipelineProvider = StateNotifierProvider<RegionalBdmFranchisePipelineNotifier, RegionalBdmFranchisePipelineModel>((ref) {
  return RegionalBdmFranchisePipelineNotifier()..loadData();
});
