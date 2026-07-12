import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chiropractor_appointments_model.dart';

class ChiropractorAppointmentsNotifier extends StateNotifier<ChiropractorAppointmentsModel> {
  ChiropractorAppointmentsNotifier() : super(const ChiropractorAppointmentsModel(isLoading: true));

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

final chiropractor_appointmentsProvider = StateNotifierProvider<ChiropractorAppointmentsNotifier, ChiropractorAppointmentsModel>((ref) {
  return ChiropractorAppointmentsNotifier()..loadData();
});
