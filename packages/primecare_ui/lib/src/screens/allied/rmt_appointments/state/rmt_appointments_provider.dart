import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_appointments_model.dart';

class RmtAppointmentsNotifier extends StateNotifier<RmtAppointmentsModel> {
  RmtAppointmentsNotifier() : super(const RmtAppointmentsModel(isLoading: true));

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

final rmt_appointmentsProvider = StateNotifierProvider<RmtAppointmentsNotifier, RmtAppointmentsModel>((ref) {
  return RmtAppointmentsNotifier()..loadData();
});
