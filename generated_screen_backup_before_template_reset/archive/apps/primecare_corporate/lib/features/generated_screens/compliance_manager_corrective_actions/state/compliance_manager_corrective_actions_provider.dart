import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_corrective_actions_model.dart';

class ComplianceManagerCorrectiveActionsNotifier extends StateNotifier<ComplianceManagerCorrectiveActionsModel> {
  ComplianceManagerCorrectiveActionsNotifier() : super(const ComplianceManagerCorrectiveActionsModel(isLoading: true));

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

final compliance_manager_corrective_actionsProvider = StateNotifierProvider<ComplianceManagerCorrectiveActionsNotifier, ComplianceManagerCorrectiveActionsModel>((ref) {
  return ComplianceManagerCorrectiveActionsNotifier()..loadData();
});
