import 'package:flutter_riverpod/legacy.dart';
import '../models/patient_my_appointments_model.dart';

class PatientMyAppointmentsNotifier extends StateNotifier<PatientMyAppointmentsModel> {
  PatientMyAppointmentsNotifier() : super(const PatientMyAppointmentsModel(isLoading: true));

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

final patient_my_appointmentsProvider = StateNotifierProvider<PatientMyAppointmentsNotifier, PatientMyAppointmentsModel>((ref) {
  return PatientMyAppointmentsNotifier()..loadData();
});
