import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_outreach_programs_model.dart';

class CommunityOutreachProgramsNotifier extends StateNotifier<CommunityOutreachProgramsModel> {
  CommunityOutreachProgramsNotifier() : super(const CommunityOutreachProgramsModel(isLoading: true));

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

final community_outreach_programsProvider = StateNotifierProvider<CommunityOutreachProgramsNotifier, CommunityOutreachProgramsModel>((ref) {
  return CommunityOutreachProgramsNotifier()..loadData();
});
