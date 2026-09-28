import 'package:flutter_riverpod/legacy.dart';
import '../models/compliance_manager_audits_model.dart';

class ComplianceManagerAuditsNotifier extends StateNotifier<ComplianceManagerAuditsModel> {
  ComplianceManagerAuditsNotifier() : super(const ComplianceManagerAuditsModel(isLoading: true));

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

final compliance_manager_auditsProvider = StateNotifierProvider<ComplianceManagerAuditsNotifier, ComplianceManagerAuditsModel>((ref) {
  return ComplianceManagerAuditsNotifier()..loadData();
});
