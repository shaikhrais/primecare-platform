import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_compliance_model.dart';

class PatientComplianceNotifier extends StateNotifier<PatientComplianceModel> {
  PatientComplianceNotifier() : super(const PatientComplianceModel(isLoading: true));

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

final patient_complianceProvider = StateNotifierProvider<PatientComplianceNotifier, PatientComplianceModel>((ref) {
  return PatientComplianceNotifier()..loadData();
});
