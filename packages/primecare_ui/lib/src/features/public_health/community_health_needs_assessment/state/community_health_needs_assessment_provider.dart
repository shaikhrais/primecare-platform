import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_health_needs_assessment_model.dart';

class CommunityHealthNeedsAssessmentNotifier extends StateNotifier<CommunityHealthNeedsAssessmentModel> {
  CommunityHealthNeedsAssessmentNotifier() : super(const CommunityHealthNeedsAssessmentModel(isLoading: true));

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

final community_health_needs_assessmentProvider = StateNotifierProvider<CommunityHealthNeedsAssessmentNotifier, CommunityHealthNeedsAssessmentModel>((ref) {
  return CommunityHealthNeedsAssessmentNotifier()..loadData();
});
