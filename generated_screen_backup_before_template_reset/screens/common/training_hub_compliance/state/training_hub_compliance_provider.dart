import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_hub_compliance_model.dart';

class TrainingHubComplianceNotifier extends StateNotifier<TrainingHubComplianceModel> {
  TrainingHubComplianceNotifier() : super(const TrainingHubComplianceModel(isLoading: true));

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

final training_hub_complianceProvider = StateNotifierProvider<TrainingHubComplianceNotifier, TrainingHubComplianceModel>((ref) {
  return TrainingHubComplianceNotifier()..loadData();
});
