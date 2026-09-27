import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PartnershipManagerAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  PartnershipManagerAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PartnershipManagerAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PartnershipManagerAnalyticsScreenController extends StateNotifier<PartnershipManagerAnalyticsScreenState> {
  final Ref ref;
  PartnershipManagerAnalyticsScreenController(this.ref) : super(PartnershipManagerAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/partnership-manager-analytics');
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

final partnership_manager_analyticsControllerProvider = StateNotifierProvider<PartnershipManagerAnalyticsScreenController, PartnershipManagerAnalyticsScreenState>((ref) {
  return PartnershipManagerAnalyticsScreenController(ref);
});
