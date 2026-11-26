import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreenState extends DashboardState<OnboardingScreenState> {
  OnboardingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OnboardingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OnboardingScreenState(isLoading: isLoading, error: error, data: data);
}

class OnboardingScreenController
    extends BaseDashboardController<OnboardingScreenState> {
  OnboardingScreenController(Ref ref)
    : super(
        ref,
        initialState: OnboardingScreenState(isLoading: true, data: {}),
        endpoint: '/management/onboarding',
      );
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingScreenController, OnboardingScreenState>((
      ref,
    ) {
      return OnboardingScreenController(ref);
    });
