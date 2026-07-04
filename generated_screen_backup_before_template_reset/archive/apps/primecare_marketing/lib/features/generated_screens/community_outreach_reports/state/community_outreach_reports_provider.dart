import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_outreach_reports_model.dart';

class CommunityOutreachReportsNotifier extends StateNotifier<CommunityOutreachReportsModel> {
  CommunityOutreachReportsNotifier() : super(const CommunityOutreachReportsModel(isLoading: true));

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

final community_outreach_reportsProvider = StateNotifierProvider<CommunityOutreachReportsNotifier, CommunityOutreachReportsModel>((ref) {
  return CommunityOutreachReportsNotifier()..loadData();
});
