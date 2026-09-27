import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_director_compliance_model.dart';

class TrainingDirectorComplianceNotifier extends StateNotifier<TrainingDirectorComplianceModel> {
  TrainingDirectorComplianceNotifier() : super(const TrainingDirectorComplianceModel(isLoading: true));

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

final training_director_complianceProvider = StateNotifierProvider<TrainingDirectorComplianceNotifier, TrainingDirectorComplianceModel>((ref) {
  return TrainingDirectorComplianceNotifier()..loadData();
});
