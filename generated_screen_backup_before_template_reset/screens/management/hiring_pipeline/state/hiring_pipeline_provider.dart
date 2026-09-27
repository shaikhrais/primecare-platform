import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hiring_pipeline_model.dart';

class HiringPipelineNotifier extends StateNotifier<HiringPipelineModel> {
  HiringPipelineNotifier() : super(const HiringPipelineModel(isLoading: true));

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

final hiring_pipelineProvider = StateNotifierProvider<HiringPipelineNotifier, HiringPipelineModel>((ref) {
  return HiringPipelineNotifier()..loadData();
});
