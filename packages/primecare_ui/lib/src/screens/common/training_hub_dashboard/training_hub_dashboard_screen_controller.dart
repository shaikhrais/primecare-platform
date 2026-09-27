import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TrainingHubDashboardScreenState({required this.isLoading, this.error, required this.data});

  TrainingHubDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TrainingHubDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TrainingHubDashboardScreenController extends StateNotifier<TrainingHubDashboardScreenState> {
  final Ref ref;
  TrainingHubDashboardScreenController(this.ref) : super(TrainingHubDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/training-hub-dashboard');
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

final training_hub_dashboardControllerProvider = StateNotifierProvider<TrainingHubDashboardScreenController, TrainingHubDashboardScreenState>((ref) {
  return TrainingHubDashboardScreenController(ref);
});
