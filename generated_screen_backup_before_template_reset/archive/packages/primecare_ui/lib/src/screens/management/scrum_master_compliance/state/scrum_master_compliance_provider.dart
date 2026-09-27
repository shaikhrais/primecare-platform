import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scrum_master_compliance_model.dart';

class ScrumMasterComplianceNotifier extends StateNotifier<ScrumMasterComplianceModel> {
  ScrumMasterComplianceNotifier() : super(const ScrumMasterComplianceModel(isLoading: true));

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

final scrum_master_complianceProvider = StateNotifierProvider<ScrumMasterComplianceNotifier, ScrumMasterComplianceModel>((ref) {
  return ScrumMasterComplianceNotifier()..loadData();
});
