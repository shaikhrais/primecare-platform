import 'package:flutter_riverpod/legacy.dart';
import '../models/client_book_appointment_model.dart';

class ClientBookAppointmentNotifier extends StateNotifier<ClientBookAppointmentModel> {
  ClientBookAppointmentNotifier() : super(const ClientBookAppointmentModel(isLoading: true));

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

final client_book_appointmentProvider = StateNotifierProvider<ClientBookAppointmentNotifier, ClientBookAppointmentModel>((ref) {
  return ClientBookAppointmentNotifier()..loadData();
});
