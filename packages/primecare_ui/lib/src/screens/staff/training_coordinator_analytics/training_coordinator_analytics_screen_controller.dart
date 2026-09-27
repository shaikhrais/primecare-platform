import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TrainingCoordinatorAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  TrainingCoordinatorAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TrainingCoordinatorAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TrainingCoordinatorAnalyticsScreenController extends StateNotifier<TrainingCoordinatorAnalyticsScreenState> {
  final Ref ref;
  TrainingCoordinatorAnalyticsScreenController(this.ref) : super(TrainingCoordinatorAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/training-coordinator-analytics');
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

final training_coordinator_analyticsControllerProvider = StateNotifierProvider<TrainingCoordinatorAnalyticsScreenController, TrainingCoordinatorAnalyticsScreenState>((ref) {
  return TrainingCoordinatorAnalyticsScreenController(ref);
});
