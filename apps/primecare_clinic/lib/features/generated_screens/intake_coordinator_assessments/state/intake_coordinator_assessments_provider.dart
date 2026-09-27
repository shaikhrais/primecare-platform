import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_assessments_model.dart';

class IntakeCoordinatorAssessmentsNotifier extends StateNotifier<IntakeCoordinatorAssessmentsModel> {
  IntakeCoordinatorAssessmentsNotifier() : super(const IntakeCoordinatorAssessmentsModel(isLoading: true));

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

final intake_coordinator_assessmentsProvider = StateNotifierProvider<IntakeCoordinatorAssessmentsNotifier, IntakeCoordinatorAssessmentsModel>((ref) {
  return IntakeCoordinatorAssessmentsNotifier()..loadData();
});
