import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringApplicantsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HrHiringApplicantsScreenState({required this.isLoading, this.error, required this.data});

  HrHiringApplicantsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HrHiringApplicantsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HrHiringApplicantsScreenController extends StateNotifier<HrHiringApplicantsScreenState> {
  final Ref ref;
  HrHiringApplicantsScreenController(this.ref) : super(HrHiringApplicantsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/franchise/roles/hr_hiring/applicants');
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          data: responseData is Map ? Map<String, dynamic>.from(responseData) : {},
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

final hr_hiring_applicantsControllerProvider = StateNotifierProvider<HrHiringApplicantsScreenController, HrHiringApplicantsScreenState>((ref) {
  return HrHiringApplicantsScreenController(ref);
});
