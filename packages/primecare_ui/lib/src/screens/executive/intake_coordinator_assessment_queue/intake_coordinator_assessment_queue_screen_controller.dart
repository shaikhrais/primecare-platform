import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorAssessmentQueueScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  IntakeCoordinatorAssessmentQueueScreenState({required this.isLoading, this.error, required this.data});

  IntakeCoordinatorAssessmentQueueScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return IntakeCoordinatorAssessmentQueueScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class IntakeCoordinatorAssessmentQueueScreenController extends StateNotifier<IntakeCoordinatorAssessmentQueueScreenState> {
  final Ref ref;
  IntakeCoordinatorAssessmentQueueScreenController(this.ref) : super(IntakeCoordinatorAssessmentQueueScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/intake-coordinator-assessment-queue');
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

final intake_coordinator_assessment_queueControllerProvider = StateNotifierProvider<IntakeCoordinatorAssessmentQueueScreenController, IntakeCoordinatorAssessmentQueueScreenState>((ref) {
  return IntakeCoordinatorAssessmentQueueScreenController(ref);
});
