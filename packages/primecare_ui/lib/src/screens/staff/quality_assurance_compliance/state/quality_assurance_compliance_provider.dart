import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quality_assurance_compliance_model.dart';

class QualityAssuranceComplianceNotifier extends StateNotifier<QualityAssuranceComplianceModel> {
  QualityAssuranceComplianceNotifier() : super(const QualityAssuranceComplianceModel(isLoading: true));

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

final quality_assurance_complianceProvider = StateNotifierProvider<QualityAssuranceComplianceNotifier, QualityAssuranceComplianceModel>((ref) {
  return QualityAssuranceComplianceNotifier()..loadData();
});
