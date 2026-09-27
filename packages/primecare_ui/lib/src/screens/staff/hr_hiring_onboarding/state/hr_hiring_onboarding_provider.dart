import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_onboarding_model.dart';

class HrHiringOnboardingNotifier extends StateNotifier<HrHiringOnboardingModel> {
  HrHiringOnboardingNotifier() : super(const HrHiringOnboardingModel(isLoading: true));

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

final hr_hiring_onboardingProvider = StateNotifierProvider<HrHiringOnboardingNotifier, HrHiringOnboardingModel>((ref) {
  return HrHiringOnboardingNotifier()..loadData();
});
