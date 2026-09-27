import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_incident_review_model.dart';

class ComplianceManagerIncidentReviewNotifier extends StateNotifier<ComplianceManagerIncidentReviewModel> {
  ComplianceManagerIncidentReviewNotifier() : super(const ComplianceManagerIncidentReviewModel(isLoading: true));

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

final compliance_manager_incident_reviewProvider = StateNotifierProvider<ComplianceManagerIncidentReviewNotifier, ComplianceManagerIncidentReviewModel>((ref) {
  return ComplianceManagerIncidentReviewNotifier()..loadData();
});
