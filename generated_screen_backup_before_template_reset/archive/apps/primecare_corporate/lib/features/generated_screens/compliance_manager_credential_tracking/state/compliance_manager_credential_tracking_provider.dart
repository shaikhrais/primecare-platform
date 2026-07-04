import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_credential_tracking_model.dart';

class ComplianceManagerCredentialTrackingNotifier extends StateNotifier<ComplianceManagerCredentialTrackingModel> {
  ComplianceManagerCredentialTrackingNotifier() : super(const ComplianceManagerCredentialTrackingModel(isLoading: true));

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

final compliance_manager_credential_trackingProvider = StateNotifierProvider<ComplianceManagerCredentialTrackingNotifier, ComplianceManagerCredentialTrackingModel>((ref) {
  return ComplianceManagerCredentialTrackingNotifier()..loadData();
});
