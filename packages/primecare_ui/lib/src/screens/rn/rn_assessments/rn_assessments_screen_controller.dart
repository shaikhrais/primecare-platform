import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnAssessmentsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RnAssessmentsScreenState({required this.isLoading, this.error, required this.data});

  RnAssessmentsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RnAssessmentsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RnAssessmentsScreenController extends StateNotifier<RnAssessmentsScreenState> {
  final Ref ref;
  RnAssessmentsScreenController(this.ref) : super(RnAssessmentsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rn/rn-assessments');
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

final rn_assessmentsControllerProvider = StateNotifierProvider<RnAssessmentsScreenController, RnAssessmentsScreenState>((ref) {
  return RnAssessmentsScreenController(ref);
});
