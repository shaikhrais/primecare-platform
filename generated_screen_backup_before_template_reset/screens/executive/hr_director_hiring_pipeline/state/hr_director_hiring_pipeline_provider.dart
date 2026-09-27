import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_hiring_pipeline_model.dart';

class HrDirectorHiringPipelineNotifier extends StateNotifier<HrDirectorHiringPipelineModel> {
  HrDirectorHiringPipelineNotifier() : super(const HrDirectorHiringPipelineModel(isLoading: true));

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

final hr_director_hiring_pipelineProvider = StateNotifierProvider<HrDirectorHiringPipelineNotifier, HrDirectorHiringPipelineModel>((ref) {
  return HrDirectorHiringPipelineNotifier()..loadData();
});
