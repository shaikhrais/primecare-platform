import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/partnership_manager_compliance_model.dart';

class PartnershipManagerComplianceNotifier extends StateNotifier<PartnershipManagerComplianceModel> {
  PartnershipManagerComplianceNotifier() : super(const PartnershipManagerComplianceModel(isLoading: true));

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

final partnership_manager_complianceProvider = StateNotifierProvider<PartnershipManagerComplianceNotifier, PartnershipManagerComplianceModel>((ref) {
  return PartnershipManagerComplianceNotifier()..loadData();
});
