import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receptionist_appointments_model.dart';

class ReceptionistAppointmentsNotifier extends StateNotifier<ReceptionistAppointmentsModel> {
  ReceptionistAppointmentsNotifier() : super(const ReceptionistAppointmentsModel(isLoading: true));

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

final receptionist_appointmentsProvider = StateNotifierProvider<ReceptionistAppointmentsNotifier, ReceptionistAppointmentsModel>((ref) {
  return ReceptionistAppointmentsNotifier()..loadData();
});
