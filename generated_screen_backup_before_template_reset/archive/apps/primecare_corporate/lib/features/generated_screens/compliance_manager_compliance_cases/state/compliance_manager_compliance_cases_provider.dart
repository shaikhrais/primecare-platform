import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_compliance_cases_model.dart';

class ComplianceManagerComplianceCasesNotifier extends StateNotifier<ComplianceManagerComplianceCasesModel> {
  ComplianceManagerComplianceCasesNotifier() : super(const ComplianceManagerComplianceCasesModel(isLoading: true));

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

final compliance_manager_compliance_casesProvider = StateNotifierProvider<ComplianceManagerComplianceCasesNotifier, ComplianceManagerComplianceCasesModel>((ref) {
  return ComplianceManagerComplianceCasesNotifier()..loadData();
});
