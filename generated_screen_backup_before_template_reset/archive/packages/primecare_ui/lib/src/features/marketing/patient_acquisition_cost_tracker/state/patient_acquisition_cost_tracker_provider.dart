import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_acquisition_cost_tracker_model.dart';

class PatientAcquisitionCostTrackerNotifier extends StateNotifier<PatientAcquisitionCostTrackerModel> {
  PatientAcquisitionCostTrackerNotifier() : super(const PatientAcquisitionCostTrackerModel(isLoading: true));

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

final patient_acquisition_cost_trackerProvider = StateNotifierProvider<PatientAcquisitionCostTrackerNotifier, PatientAcquisitionCostTrackerModel>((ref) {
  return PatientAcquisitionCostTrackerNotifier()..loadData();
});
