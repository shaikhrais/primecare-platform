import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chiropractor_assessment_model.dart';

class ChiropractorAssessmentNotifier extends StateNotifier<ChiropractorAssessmentModel> {
  ChiropractorAssessmentNotifier() : super(const ChiropractorAssessmentModel(isLoading: true));

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

final chiropractor_assessmentProvider = StateNotifierProvider<ChiropractorAssessmentNotifier, ChiropractorAssessmentModel>((ref) {
  return ChiropractorAssessmentNotifier()..loadData();
});
