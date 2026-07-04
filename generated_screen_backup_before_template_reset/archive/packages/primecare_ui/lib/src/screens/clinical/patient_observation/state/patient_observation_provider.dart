import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_observation_model.dart';

class PatientObservationNotifier extends StateNotifier<PatientObservationModel> {
  PatientObservationNotifier() : super(const PatientObservationModel(isLoading: true));

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

final patient_observationProvider = StateNotifierProvider<PatientObservationNotifier, PatientObservationModel>((ref) {
  return PatientObservationNotifier()..loadData();
});
