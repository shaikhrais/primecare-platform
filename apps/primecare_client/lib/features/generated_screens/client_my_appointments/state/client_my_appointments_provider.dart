import 'package:flutter_riverpod/legacy.dart';
import '../models/client_my_appointments_model.dart';

class ClientMyAppointmentsNotifier extends StateNotifier<ClientMyAppointmentsModel> {
  ClientMyAppointmentsNotifier() : super(const ClientMyAppointmentsModel(isLoading: true));

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

final client_my_appointmentsProvider = StateNotifierProvider<ClientMyAppointmentsNotifier, ClientMyAppointmentsModel>((ref) {
  return ClientMyAppointmentsNotifier()..loadData();
});
