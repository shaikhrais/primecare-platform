import 'package:flutter_riverpod/legacy.dart';
import '../models/psw_patient_profile_model.dart';

class PswPatientProfileNotifier extends StateNotifier<PswPatientProfileModel> {
  PswPatientProfileNotifier() : super(const PswPatientProfileModel(isLoading: true));

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

final psw_patient_profileProvider = StateNotifierProvider<PswPatientProfileNotifier, PswPatientProfileModel>((ref) {
  return PswPatientProfileNotifier()..loadData();
});
