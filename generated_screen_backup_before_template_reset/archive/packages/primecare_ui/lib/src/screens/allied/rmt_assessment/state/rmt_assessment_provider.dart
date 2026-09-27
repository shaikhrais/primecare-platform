import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_assessment_model.dart';

class RmtAssessmentNotifier extends StateNotifier<RmtAssessmentModel> {
  RmtAssessmentNotifier() : super(const RmtAssessmentModel(isLoading: true));

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

final rmt_assessmentProvider = StateNotifierProvider<RmtAssessmentNotifier, RmtAssessmentModel>((ref) {
  return RmtAssessmentNotifier()..loadData();
});
