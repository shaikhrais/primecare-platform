import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ciso_compliance_model.dart';

class CisoComplianceNotifier extends StateNotifier<CisoComplianceModel> {
  CisoComplianceNotifier() : super(const CisoComplianceModel(isLoading: true));

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

final ciso_complianceProvider = StateNotifierProvider<CisoComplianceNotifier, CisoComplianceModel>((ref) {
  return CisoComplianceNotifier()..loadData();
});
