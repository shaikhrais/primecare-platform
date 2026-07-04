import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/governance_officer_compliance_model.dart';

class GovernanceOfficerComplianceNotifier extends StateNotifier<GovernanceOfficerComplianceModel> {
  GovernanceOfficerComplianceNotifier() : super(const GovernanceOfficerComplianceModel(isLoading: true));

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

final governance_officer_complianceProvider = StateNotifierProvider<GovernanceOfficerComplianceNotifier, GovernanceOfficerComplianceModel>((ref) {
  return GovernanceOfficerComplianceNotifier()..loadData();
});
