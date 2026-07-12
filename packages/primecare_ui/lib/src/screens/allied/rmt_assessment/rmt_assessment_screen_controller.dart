import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtAssessmentScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RmtAssessmentScreenState({required this.isLoading, this.error, required this.data});

  RmtAssessmentScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RmtAssessmentScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RmtAssessmentScreenController extends StateNotifier<RmtAssessmentScreenState> {
  final Ref ref;
  RmtAssessmentScreenController(this.ref) : super(RmtAssessmentScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rmt/assessment');
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

final rmt_assessmentControllerProvider = StateNotifierProvider<RmtAssessmentScreenController, RmtAssessmentScreenState>((ref) {
  return RmtAssessmentScreenController(ref);
});
