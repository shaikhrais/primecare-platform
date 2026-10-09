import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorOnboardingScreenState
    extends DashboardState<HrDirectorOnboardingScreenState> {
  HrDirectorOnboardingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorOnboardingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorOnboardingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorOnboardingScreenController
    extends BaseDashboardController<HrDirectorOnboardingScreenState> {
  HrDirectorOnboardingScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorOnboardingScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/hr-director-onboarding',
      );
}

final hr_director_onboardingControllerProvider =
    StateNotifierProvider<
      HrDirectorOnboardingScreenController,
      HrDirectorOnboardingScreenState
    >((ref) {
      return HrDirectorOnboardingScreenController(ref);
    });
