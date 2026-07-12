import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FinanceDirectorAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  FinanceDirectorAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FinanceDirectorAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FinanceDirectorAnalyticsScreenController extends StateNotifier<FinanceDirectorAnalyticsScreenState> {
  final Ref ref;
  FinanceDirectorAnalyticsScreenController(this.ref) : super(FinanceDirectorAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/finance-director-analytics');
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

final finance_director_analyticsControllerProvider = StateNotifierProvider<FinanceDirectorAnalyticsScreenController, FinanceDirectorAnalyticsScreenState>((ref) {
  return FinanceDirectorAnalyticsScreenController(ref);
});
