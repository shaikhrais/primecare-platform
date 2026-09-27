import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_compliance_model.dart';

class ClinicalComplianceNotifier extends StateNotifier<ClinicalComplianceModel> {
  ClinicalComplianceNotifier() : super(const ClinicalComplianceModel(isLoading: true));

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

final clinical_complianceProvider = StateNotifierProvider<ClinicalComplianceNotifier, ClinicalComplianceModel>((ref) {
  return ClinicalComplianceNotifier()..loadData();
});
