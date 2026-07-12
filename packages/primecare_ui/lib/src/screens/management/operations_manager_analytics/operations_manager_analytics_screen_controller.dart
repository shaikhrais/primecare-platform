import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  OperationsManagerAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  OperationsManagerAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return OperationsManagerAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class OperationsManagerAnalyticsScreenController extends StateNotifier<OperationsManagerAnalyticsScreenState> {
  final Ref ref;
  OperationsManagerAnalyticsScreenController(this.ref) : super(OperationsManagerAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/operations-manager-analytics');
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

final operations_manager_analyticsControllerProvider = StateNotifierProvider<OperationsManagerAnalyticsScreenController, OperationsManagerAnalyticsScreenState>((ref) {
  return OperationsManagerAnalyticsScreenController(ref);
});
