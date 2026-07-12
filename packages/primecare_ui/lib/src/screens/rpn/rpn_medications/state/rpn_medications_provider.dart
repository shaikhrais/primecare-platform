import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_medications_model.dart';

class RpnMedicationsNotifier extends StateNotifier<RpnMedicationsModel> {
  RpnMedicationsNotifier() : super(const RpnMedicationsModel(isLoading: true));

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

final rpn_medicationsProvider = StateNotifierProvider<RpnMedicationsNotifier, RpnMedicationsModel>((ref) {
  return RpnMedicationsNotifier()..loadData();
});
