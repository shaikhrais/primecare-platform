import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medication_model.dart';

class MedicationNotifier extends StateNotifier<MedicationModel> {
  MedicationNotifier() : super(const MedicationModel(isLoading: true));

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

final medicationProvider = StateNotifierProvider<MedicationNotifier, MedicationModel>((ref) {
  return MedicationNotifier()..loadData();
});
