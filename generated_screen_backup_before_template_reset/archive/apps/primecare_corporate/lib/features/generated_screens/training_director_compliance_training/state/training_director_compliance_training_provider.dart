import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_director_compliance_training_model.dart';

class TrainingDirectorComplianceTrainingNotifier extends StateNotifier<TrainingDirectorComplianceTrainingModel> {
  TrainingDirectorComplianceTrainingNotifier() : super(const TrainingDirectorComplianceTrainingModel(isLoading: true));

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

final training_director_compliance_trainingProvider = StateNotifierProvider<TrainingDirectorComplianceTrainingNotifier, TrainingDirectorComplianceTrainingModel>((ref) {
  return TrainingDirectorComplianceTrainingNotifier()..loadData();
});
