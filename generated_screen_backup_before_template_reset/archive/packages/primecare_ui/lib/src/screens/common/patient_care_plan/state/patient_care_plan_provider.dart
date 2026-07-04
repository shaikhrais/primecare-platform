import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_care_plan_model.dart';

class PatientCarePlanNotifier extends StateNotifier<PatientCarePlanModel> {
  PatientCarePlanNotifier() : super(const PatientCarePlanModel(isLoading: true));

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

final patient_care_planProvider = StateNotifierProvider<PatientCarePlanNotifier, PatientCarePlanModel>((ref) {
  return PatientCarePlanNotifier()..loadData();
});
