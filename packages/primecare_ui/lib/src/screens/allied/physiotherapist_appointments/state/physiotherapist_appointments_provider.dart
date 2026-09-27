import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_appointments_model.dart';

class PhysiotherapistAppointmentsNotifier extends StateNotifier<PhysiotherapistAppointmentsModel> {
  PhysiotherapistAppointmentsNotifier() : super(const PhysiotherapistAppointmentsModel(isLoading: true));

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

final physiotherapist_appointmentsProvider = StateNotifierProvider<PhysiotherapistAppointmentsNotifier, PhysiotherapistAppointmentsModel>((ref) {
  return PhysiotherapistAppointmentsNotifier()..loadData();
});
