import 'package:flutter_riverpod/legacy.dart';
import '../models/compliance_training_model.dart';

class ComplianceTrainingNotifier extends StateNotifier<ComplianceTrainingModel> {
  ComplianceTrainingNotifier() : super(const ComplianceTrainingModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final compliance_trainingProvider = StateNotifierProvider<ComplianceTrainingNotifier, ComplianceTrainingModel>((ref) {
  return ComplianceTrainingNotifier()..loadData();
});
