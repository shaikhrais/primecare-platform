import 'package:flutter_riverpod/legacy.dart';
import '../models/compliance_manager_risk_register_model.dart';

class ComplianceManagerRiskRegisterNotifier extends StateNotifier<ComplianceManagerRiskRegisterModel> {
  ComplianceManagerRiskRegisterNotifier() : super(const ComplianceManagerRiskRegisterModel(isLoading: true));

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

final compliance_manager_risk_registerProvider = StateNotifierProvider<ComplianceManagerRiskRegisterNotifier, ComplianceManagerRiskRegisterModel>((ref) {
  return ComplianceManagerRiskRegisterNotifier()..loadData();
});
