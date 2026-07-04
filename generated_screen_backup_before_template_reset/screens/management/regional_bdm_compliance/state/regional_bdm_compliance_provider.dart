import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_compliance_model.dart';

class RegionalBdmComplianceNotifier extends StateNotifier<RegionalBdmComplianceModel> {
  RegionalBdmComplianceNotifier() : super(const RegionalBdmComplianceModel(isLoading: true));

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

final regional_bdm_complianceProvider = StateNotifierProvider<RegionalBdmComplianceNotifier, RegionalBdmComplianceModel>((ref) {
  return RegionalBdmComplianceNotifier()..loadData();
});
