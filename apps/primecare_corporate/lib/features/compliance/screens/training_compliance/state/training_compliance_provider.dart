import 'package:flutter_riverpod/legacy.dart';
import '../models/training_compliance_model.dart';

class TrainingComplianceNotifier extends StateNotifier<TrainingComplianceModel> {
  TrainingComplianceNotifier() : super(const TrainingComplianceModel(isLoading: true));

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

final training_complianceProvider = StateNotifierProvider<TrainingComplianceNotifier, TrainingComplianceModel>((ref) {
  return TrainingComplianceNotifier()..loadData();
});
