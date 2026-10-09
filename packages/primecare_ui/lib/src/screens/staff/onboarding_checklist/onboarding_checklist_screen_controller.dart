import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingChecklistScreenState
    extends DashboardState<OnboardingChecklistScreenState> {
  OnboardingChecklistScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OnboardingChecklistScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OnboardingChecklistScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OnboardingChecklistScreenController
    extends BaseDashboardController<OnboardingChecklistScreenState> {
  OnboardingChecklistScreenController(Ref ref)
    : super(
        ref,
        initialState: OnboardingChecklistScreenState(isLoading: true, data: {}),
        endpoint: '/staff/onboarding-checklist',
      );
}

final onboarding_checklistControllerProvider =
    StateNotifierProvider<
      OnboardingChecklistScreenController,
      OnboardingChecklistScreenState
    >((ref) {
      return OnboardingChecklistScreenController(ref);
    });
