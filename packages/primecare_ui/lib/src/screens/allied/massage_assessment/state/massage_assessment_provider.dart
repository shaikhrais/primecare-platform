import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/massage_assessment_model.dart';

class MassageAssessmentNotifier extends StateNotifier<MassageAssessmentModel> {
  MassageAssessmentNotifier() : super(const MassageAssessmentModel(isLoading: true));

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

final massage_assessmentProvider = StateNotifierProvider<MassageAssessmentNotifier, MassageAssessmentModel>((ref) {
  return MassageAssessmentNotifier()..loadData();
});
