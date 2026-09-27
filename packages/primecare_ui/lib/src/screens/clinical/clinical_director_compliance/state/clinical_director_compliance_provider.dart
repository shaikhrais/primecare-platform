import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_director_compliance_model.dart';

class ClinicalDirectorComplianceNotifier extends StateNotifier<ClinicalDirectorComplianceModel> {
  ClinicalDirectorComplianceNotifier() : super(const ClinicalDirectorComplianceModel(isLoading: true));

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

final clinical_director_complianceProvider = StateNotifierProvider<ClinicalDirectorComplianceNotifier, ClinicalDirectorComplianceModel>((ref) {
  return ClinicalDirectorComplianceNotifier()..loadData();
});
