import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TrainingDashboardScreenState({required this.isLoading, this.error, required this.data});

  TrainingDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TrainingDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TrainingDashboardScreenController extends StateNotifier<TrainingDashboardScreenState> {
  final Ref ref;
  TrainingDashboardScreenController(this.ref) : super(TrainingDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/training-dashboard');
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

final training_dashboardControllerProvider = StateNotifierProvider<TrainingDashboardScreenController, TrainingDashboardScreenState>((ref) {
  return TrainingDashboardScreenController(ref);
});
