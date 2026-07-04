import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coo_compliance_model.dart';

class CooComplianceNotifier extends StateNotifier<CooComplianceModel> {
  CooComplianceNotifier() : super(const CooComplianceModel(isLoading: true));

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

final coo_complianceProvider = StateNotifierProvider<CooComplianceNotifier, CooComplianceModel>((ref) {
  return CooComplianceNotifier()..loadData();
});
