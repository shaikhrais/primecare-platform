import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_medications_model.dart';

class RnMedicationsNotifier extends StateNotifier<RnMedicationsModel> {
  RnMedicationsNotifier() : super(const RnMedicationsModel(isLoading: true));

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

final rn_medicationsProvider = StateNotifierProvider<RnMedicationsNotifier, RnMedicationsModel>((ref) {
  return RnMedicationsNotifier()..loadData();
});
