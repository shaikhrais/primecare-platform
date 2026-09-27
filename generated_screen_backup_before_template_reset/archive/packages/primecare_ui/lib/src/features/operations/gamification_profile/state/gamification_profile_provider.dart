import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gamification_profile_model.dart';

class GamificationProfileNotifier extends StateNotifier<GamificationProfileModel> {
  GamificationProfileNotifier() : super(const GamificationProfileModel(isLoading: true));

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

final gamification_profileProvider = StateNotifierProvider<GamificationProfileNotifier, GamificationProfileModel>((ref) {
  return GamificationProfileNotifier()..loadData();
});
