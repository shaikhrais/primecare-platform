import 'package:flutter_riverpod/legacy.dart';
import '../models/compliance_manager_training_compliance_model.dart';

class ComplianceManagerTrainingComplianceNotifier extends StateNotifier<ComplianceManagerTrainingComplianceModel> {
  ComplianceManagerTrainingComplianceNotifier() : super(const ComplianceManagerTrainingComplianceModel(isLoading: true));

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

final compliance_manager_training_complianceProvider = StateNotifierProvider<ComplianceManagerTrainingComplianceNotifier, ComplianceManagerTrainingComplianceModel>((ref) {
  return ComplianceManagerTrainingComplianceNotifier()..loadData();
});
