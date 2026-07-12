import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_onboarding_model.dart';

class HrOnboardingNotifier extends StateNotifier<HrOnboardingModel> {
  HrOnboardingNotifier() : super(const HrOnboardingModel(isLoading: true));

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

final hr_onboardingProvider = StateNotifierProvider<HrOnboardingNotifier, HrOnboardingModel>((ref) {
  return HrOnboardingNotifier()..loadData();
});
