import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_onboarding_model.dart';

class HrDirectorOnboardingNotifier extends StateNotifier<HrDirectorOnboardingModel> {
  HrDirectorOnboardingNotifier() : super(const HrDirectorOnboardingModel(isLoading: true));

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

final hr_director_onboardingProvider = StateNotifierProvider<HrDirectorOnboardingNotifier, HrDirectorOnboardingModel>((ref) {
  return HrDirectorOnboardingNotifier()..loadData();
});
