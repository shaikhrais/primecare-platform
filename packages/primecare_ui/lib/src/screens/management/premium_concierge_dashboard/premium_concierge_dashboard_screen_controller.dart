import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumConciergeDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PremiumConciergeDashboardScreenState({required this.isLoading, this.error, required this.data});

  PremiumConciergeDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PremiumConciergeDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PremiumConciergeDashboardScreenController extends StateNotifier<PremiumConciergeDashboardScreenState> {
  final Ref ref;
  PremiumConciergeDashboardScreenController(this.ref) : super(PremiumConciergeDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/premium-concierge-dashboard');
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

final premium_concierge_dashboardControllerProvider = StateNotifierProvider<PremiumConciergeDashboardScreenController, PremiumConciergeDashboardScreenState>((ref) {
  return PremiumConciergeDashboardScreenController(ref);
});
