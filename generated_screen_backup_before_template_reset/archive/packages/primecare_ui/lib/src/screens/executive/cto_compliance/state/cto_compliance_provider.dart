import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_compliance_model.dart';

class CtoComplianceNotifier extends StateNotifier<CtoComplianceModel> {
  CtoComplianceNotifier() : super(const CtoComplianceModel(isLoading: true));

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

final cto_complianceProvider = StateNotifierProvider<CtoComplianceNotifier, CtoComplianceModel>((ref) {
  return CtoComplianceNotifier()..loadData();
});
