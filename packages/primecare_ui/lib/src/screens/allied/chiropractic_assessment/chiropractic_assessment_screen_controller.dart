import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropracticAssessmentScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ChiropracticAssessmentScreenState({required this.isLoading, this.error, required this.data});

  ChiropracticAssessmentScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ChiropracticAssessmentScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ChiropracticAssessmentScreenController extends StateNotifier<ChiropracticAssessmentScreenState> {
  final Ref ref;
  ChiropracticAssessmentScreenController(this.ref) : super(ChiropracticAssessmentScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/chiropractor/chiropractic-assessment');
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

final chiropractic_assessmentControllerProvider = StateNotifierProvider<ChiropracticAssessmentScreenController, ChiropracticAssessmentScreenState>((ref) {
  return ChiropracticAssessmentScreenController(ref);
});
