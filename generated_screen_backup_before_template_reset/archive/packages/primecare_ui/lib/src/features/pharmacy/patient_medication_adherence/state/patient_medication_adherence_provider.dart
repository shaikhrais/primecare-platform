import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_medication_adherence_model.dart';

class PatientMedicationAdherenceNotifier extends StateNotifier<PatientMedicationAdherenceModel> {
  PatientMedicationAdherenceNotifier() : super(const PatientMedicationAdherenceModel(isLoading: true));

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

final patient_medication_adherenceProvider = StateNotifierProvider<PatientMedicationAdherenceNotifier, PatientMedicationAdherenceModel>((ref) {
  return PatientMedicationAdherenceNotifier()..loadData();
});
