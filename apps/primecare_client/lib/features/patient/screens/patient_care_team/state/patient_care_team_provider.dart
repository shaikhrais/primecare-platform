import 'package:flutter_riverpod/legacy.dart';
import '../models/patient_care_team_model.dart';

class PatientCareTeamNotifier extends StateNotifier<PatientCareTeamModel> {
  PatientCareTeamNotifier() : super(const PatientCareTeamModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final patient_care_teamProvider = StateNotifierProvider<PatientCareTeamNotifier, PatientCareTeamModel>((ref) {
  return PatientCareTeamNotifier()..loadData();
});
