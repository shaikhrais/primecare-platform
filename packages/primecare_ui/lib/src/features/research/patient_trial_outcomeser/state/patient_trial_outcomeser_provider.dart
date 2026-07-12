import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_trial_outcomeser_model.dart';

class PatientTrialOutcomeserNotifier extends StateNotifier<PatientTrialOutcomeserModel> {
  PatientTrialOutcomeserNotifier() : super(const PatientTrialOutcomeserModel(isLoading: true));

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

final patient_trial_outcomeserProvider = StateNotifierProvider<PatientTrialOutcomeserNotifier, PatientTrialOutcomeserModel>((ref) {
  return PatientTrialOutcomeserNotifier()..loadData();
});
