import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_compliance_model.dart';

class RpnComplianceNotifier extends StateNotifier<RpnComplianceModel> {
  RpnComplianceNotifier() : super(const RpnComplianceModel(isLoading: true));

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

final rpn_complianceProvider = StateNotifierProvider<RpnComplianceNotifier, RpnComplianceModel>((ref) {
  return RpnComplianceNotifier()..loadData();
});
