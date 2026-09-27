import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_assessment_model.dart';

class PhysiotherapistAssessmentNotifier extends StateNotifier<PhysiotherapistAssessmentModel> {
  PhysiotherapistAssessmentNotifier() : super(const PhysiotherapistAssessmentModel(isLoading: true));

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

final physiotherapist_assessmentProvider = StateNotifierProvider<PhysiotherapistAssessmentNotifier, PhysiotherapistAssessmentModel>((ref) {
  return PhysiotherapistAssessmentNotifier()..loadData();
});
