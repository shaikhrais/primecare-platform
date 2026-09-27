import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_appointments_model.dart';

class PatientAppointmentsNotifier extends StateNotifier<PatientAppointmentsModel> {
  PatientAppointmentsNotifier() : super(const PatientAppointmentsModel(isLoading: true));

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

final patient_appointmentsProvider = StateNotifierProvider<PatientAppointmentsNotifier, PatientAppointmentsModel>((ref) {
  return PatientAppointmentsNotifier()..loadData();
});
