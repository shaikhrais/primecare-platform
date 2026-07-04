import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_vitals_model.dart';

class RpnVitalsNotifier extends StateNotifier<RpnVitalsModel> {
  RpnVitalsNotifier() : super(const RpnVitalsModel(isLoading: true));

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

final rpn_vitalsProvider = StateNotifierProvider<RpnVitalsNotifier, RpnVitalsModel>((ref) {
  return RpnVitalsNotifier()..loadData();
});
