import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringOnboardingScreenState
    extends DashboardState<HrHiringOnboardingScreenState> {
  HrHiringOnboardingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringOnboardingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrHiringOnboardingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrHiringOnboardingScreenController
    extends BaseDashboardController<HrHiringOnboardingScreenState> {
  HrHiringOnboardingScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringOnboardingScreenState(isLoading: true, data: {}),
        endpoint: '/offices/franchise/roles/hr_hiring/onboarding',
      );
}

final hr_hiring_onboardingControllerProvider =
    StateNotifierProvider<
      HrHiringOnboardingScreenController,
      HrHiringOnboardingScreenState
    >((ref) {
      return HrHiringOnboardingScreenController(ref);
    });
