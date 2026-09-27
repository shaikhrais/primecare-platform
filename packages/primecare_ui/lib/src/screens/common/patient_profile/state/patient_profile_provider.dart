import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_profile_model.dart';

class PatientProfileNotifier extends StateNotifier<PatientProfileModel> {
  PatientProfileNotifier() : super(const PatientProfileModel(isLoading: true));

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

final patient_profileProvider = StateNotifierProvider<PatientProfileNotifier, PatientProfileModel>((ref) {
  return PatientProfileNotifier()..loadData();
});
