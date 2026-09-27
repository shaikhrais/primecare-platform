import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medication_administration_model.dart';

class MedicationAdministrationNotifier extends StateNotifier<MedicationAdministrationModel> {
  MedicationAdministrationNotifier() : super(const MedicationAdministrationModel(isLoading: true));

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

final medication_administrationProvider = StateNotifierProvider<MedicationAdministrationNotifier, MedicationAdministrationModel>((ref) {
  return MedicationAdministrationNotifier()..loadData();
});
