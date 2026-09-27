import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cx_director_compliance_model.dart';

class CxDirectorComplianceNotifier extends StateNotifier<CxDirectorComplianceModel> {
  CxDirectorComplianceNotifier() : super(const CxDirectorComplianceModel(isLoading: true));

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

final cx_director_complianceProvider = StateNotifierProvider<CxDirectorComplianceNotifier, CxDirectorComplianceModel>((ref) {
  return CxDirectorComplianceNotifier()..loadData();
});
