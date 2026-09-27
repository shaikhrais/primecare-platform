import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_book_appointment_model.dart';

class PatientBookAppointmentNotifier extends StateNotifier<PatientBookAppointmentModel> {
  PatientBookAppointmentNotifier() : super(const PatientBookAppointmentModel(isLoading: true));

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

final patient_book_appointmentProvider = StateNotifierProvider<PatientBookAppointmentNotifier, PatientBookAppointmentModel>((ref) {
  return PatientBookAppointmentNotifier()..loadData();
});
