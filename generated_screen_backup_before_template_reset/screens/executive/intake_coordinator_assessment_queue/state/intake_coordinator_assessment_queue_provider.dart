import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_assessment_queue_model.dart';

class IntakeCoordinatorAssessmentQueueNotifier extends StateNotifier<IntakeCoordinatorAssessmentQueueModel> {
  IntakeCoordinatorAssessmentQueueNotifier() : super(const IntakeCoordinatorAssessmentQueueModel(isLoading: true));

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

final intake_coordinator_assessment_queueProvider = StateNotifierProvider<IntakeCoordinatorAssessmentQueueNotifier, IntakeCoordinatorAssessmentQueueModel>((ref) {
  return IntakeCoordinatorAssessmentQueueNotifier()..loadData();
});
