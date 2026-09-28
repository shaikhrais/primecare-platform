import 'package:flutter_riverpod/legacy.dart';
import '../models/community_outreach_follow_ups_model.dart';

class CommunityOutreachFollowUpsNotifier extends StateNotifier<CommunityOutreachFollowUpsModel> {
  CommunityOutreachFollowUpsNotifier() : super(const CommunityOutreachFollowUpsModel(isLoading: true));

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

final community_outreach_follow_upsProvider = StateNotifierProvider<CommunityOutreachFollowUpsNotifier, CommunityOutreachFollowUpsModel>((ref) {
  return CommunityOutreachFollowUpsNotifier()..loadData();
});
