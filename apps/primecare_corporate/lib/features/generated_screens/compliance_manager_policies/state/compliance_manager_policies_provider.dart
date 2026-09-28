import 'package:flutter_riverpod/legacy.dart';
import '../models/compliance_manager_policies_model.dart';

class ComplianceManagerPoliciesNotifier extends StateNotifier<ComplianceManagerPoliciesModel> {
  ComplianceManagerPoliciesNotifier() : super(const ComplianceManagerPoliciesModel(isLoading: true));

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

final compliance_manager_policiesProvider = StateNotifierProvider<ComplianceManagerPoliciesNotifier, ComplianceManagerPoliciesModel>((ref) {
  return ComplianceManagerPoliciesNotifier()..loadData();
});
