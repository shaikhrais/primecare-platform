import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_vitals_log_model.dart';

class PswVitalsLogNotifier extends StateNotifier<PswVitalsLogModel> {
  PswVitalsLogNotifier() : super(const PswVitalsLogModel(isLoading: true));

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

final psw_vitals_logProvider = StateNotifierProvider<PswVitalsLogNotifier, PswVitalsLogModel>((ref) {
  return PswVitalsLogNotifier()..loadData();
});
