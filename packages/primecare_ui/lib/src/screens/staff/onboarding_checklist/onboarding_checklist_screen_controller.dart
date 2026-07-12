import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingChecklistScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  OnboardingChecklistScreenState({required this.isLoading, this.error, required this.data});

  OnboardingChecklistScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return OnboardingChecklistScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class OnboardingChecklistScreenController extends StateNotifier<OnboardingChecklistScreenState> {
  final Ref ref;
  OnboardingChecklistScreenController(this.ref) : super(OnboardingChecklistScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/onboarding-checklist');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final onboarding_checklistControllerProvider = StateNotifierProvider<OnboardingChecklistScreenController, OnboardingChecklistScreenState>((ref) {
  return OnboardingChecklistScreenController(ref);
});
