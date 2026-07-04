import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_training_tracker_model.dart';

class ComplianceTrainingTrackerNotifier extends StateNotifier<ComplianceTrainingTrackerModel> {
  ComplianceTrainingTrackerNotifier() : super(const ComplianceTrainingTrackerModel(isLoading: true));

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

final compliance_training_trackerProvider = StateNotifierProvider<ComplianceTrainingTrackerNotifier, ComplianceTrainingTrackerModel>((ref) {
  return ComplianceTrainingTrackerNotifier()..loadData();
});
