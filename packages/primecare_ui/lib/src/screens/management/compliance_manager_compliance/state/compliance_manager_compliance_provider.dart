import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_compliance_model.dart';

class ComplianceManagerComplianceNotifier extends StateNotifier<ComplianceManagerComplianceModel> {
  ComplianceManagerComplianceNotifier() : super(const ComplianceManagerComplianceModel(isLoading: true));

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

final compliance_manager_complianceProvider = StateNotifierProvider<ComplianceManagerComplianceNotifier, ComplianceManagerComplianceModel>((ref) {
  return ComplianceManagerComplianceNotifier()..loadData();
});
