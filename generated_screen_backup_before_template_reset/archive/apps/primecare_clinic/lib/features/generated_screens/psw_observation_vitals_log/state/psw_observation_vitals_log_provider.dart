import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_observation_vitals_log_model.dart';

class PswObservationVitalsLogNotifier extends StateNotifier<PswObservationVitalsLogModel> {
  PswObservationVitalsLogNotifier() : super(const PswObservationVitalsLogModel(isLoading: true));

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

final psw_observation_vitals_logProvider = StateNotifierProvider<PswObservationVitalsLogNotifier, PswObservationVitalsLogModel>((ref) {
  return PswObservationVitalsLogNotifier()..loadData();
});
