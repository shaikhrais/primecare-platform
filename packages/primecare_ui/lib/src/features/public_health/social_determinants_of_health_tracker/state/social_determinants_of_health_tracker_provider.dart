import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_determinants_of_health_tracker_model.dart';

class SocialDeterminantsOfHealthTrackerNotifier extends StateNotifier<SocialDeterminantsOfHealthTrackerModel> {
  SocialDeterminantsOfHealthTrackerNotifier() : super(const SocialDeterminantsOfHealthTrackerModel(isLoading: true));

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

final social_determinants_of_health_trackerProvider = StateNotifierProvider<SocialDeterminantsOfHealthTrackerNotifier, SocialDeterminantsOfHealthTrackerModel>((ref) {
  return SocialDeterminantsOfHealthTrackerNotifier()..loadData();
});
