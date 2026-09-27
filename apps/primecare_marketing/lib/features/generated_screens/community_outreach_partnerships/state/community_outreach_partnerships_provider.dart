import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_outreach_partnerships_model.dart';

class CommunityOutreachPartnershipsNotifier extends StateNotifier<CommunityOutreachPartnershipsModel> {
  CommunityOutreachPartnershipsNotifier() : super(const CommunityOutreachPartnershipsModel(isLoading: true));

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

final community_outreach_partnershipsProvider = StateNotifierProvider<CommunityOutreachPartnershipsNotifier, CommunityOutreachPartnershipsModel>((ref) {
  return CommunityOutreachPartnershipsNotifier()..loadData();
});
