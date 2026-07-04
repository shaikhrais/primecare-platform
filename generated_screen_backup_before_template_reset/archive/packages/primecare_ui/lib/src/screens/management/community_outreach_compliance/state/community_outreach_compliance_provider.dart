import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_outreach_compliance_model.dart';

class CommunityOutreachComplianceNotifier extends StateNotifier<CommunityOutreachComplianceModel> {
  CommunityOutreachComplianceNotifier() : super(const CommunityOutreachComplianceModel(isLoading: true));

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

final community_outreach_complianceProvider = StateNotifierProvider<CommunityOutreachComplianceNotifier, CommunityOutreachComplianceModel>((ref) {
  return CommunityOutreachComplianceNotifier()..loadData();
});
