import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumConciergeCareCoordinatorAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PremiumConciergeCareCoordinatorAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  PremiumConciergeCareCoordinatorAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PremiumConciergeCareCoordinatorAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PremiumConciergeCareCoordinatorAnalyticsScreenController extends StateNotifier<PremiumConciergeCareCoordinatorAnalyticsScreenState> {
  final Ref ref;
  PremiumConciergeCareCoordinatorAnalyticsScreenController(this.ref) : super(PremiumConciergeCareCoordinatorAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/premium/premium-concierge-analytics');
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

final premium_concierge_analyticsControllerProvider = StateNotifierProvider<PremiumConciergeCareCoordinatorAnalyticsScreenController, PremiumConciergeCareCoordinatorAnalyticsScreenState>((ref) {
  return PremiumConciergeCareCoordinatorAnalyticsScreenController(ref);
});
