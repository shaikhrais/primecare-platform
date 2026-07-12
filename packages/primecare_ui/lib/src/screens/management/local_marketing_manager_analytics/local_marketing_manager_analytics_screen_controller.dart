import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  LocalMarketingManagerAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  LocalMarketingManagerAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return LocalMarketingManagerAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class LocalMarketingManagerAnalyticsScreenController extends StateNotifier<LocalMarketingManagerAnalyticsScreenState> {
  final Ref ref;
  LocalMarketingManagerAnalyticsScreenController(this.ref) : super(LocalMarketingManagerAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/local-marketing-manager-analytics');
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

final local_marketing_manager_analyticsControllerProvider = StateNotifierProvider<LocalMarketingManagerAnalyticsScreenController, LocalMarketingManagerAnalyticsScreenState>((ref) {
  return LocalMarketingManagerAnalyticsScreenController(ref);
});
