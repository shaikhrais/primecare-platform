import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_treatment_history_model.dart';

class PatientTreatmentHistoryNotifier extends StateNotifier<PatientTreatmentHistoryModel> {
  PatientTreatmentHistoryNotifier() : super(const PatientTreatmentHistoryModel(isLoading: true));

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

final patient_treatment_historyProvider = StateNotifierProvider<PatientTreatmentHistoryNotifier, PatientTreatmentHistoryModel>((ref) {
  return PatientTreatmentHistoryNotifier()..loadData();
});
