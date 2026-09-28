import 'package:flutter_riverpod/legacy.dart';
import '../models/quality_assurance_compliance_checks_model.dart';

class QualityAssuranceComplianceChecksNotifier extends StateNotifier<QualityAssuranceComplianceChecksModel> {
  QualityAssuranceComplianceChecksNotifier() : super(const QualityAssuranceComplianceChecksModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final quality_assurance_compliance_checksProvider = StateNotifierProvider<QualityAssuranceComplianceChecksNotifier, QualityAssuranceComplianceChecksModel>((ref) {
  return QualityAssuranceComplianceChecksNotifier()..loadData();
});
