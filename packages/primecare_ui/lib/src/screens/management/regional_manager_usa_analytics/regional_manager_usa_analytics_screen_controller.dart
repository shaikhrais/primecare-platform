import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RegionalManagerUsaAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  RegionalManagerUsaAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RegionalManagerUsaAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RegionalManagerUsaAnalyticsScreenController extends StateNotifier<RegionalManagerUsaAnalyticsScreenState> {
  final Ref ref;
  RegionalManagerUsaAnalyticsScreenController(this.ref) : super(RegionalManagerUsaAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/regional-manager-usa-analytics');
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

final regional_manager_usa_analyticsControllerProvider = StateNotifierProvider<RegionalManagerUsaAnalyticsScreenController, RegionalManagerUsaAnalyticsScreenState>((ref) {
  return RegionalManagerUsaAnalyticsScreenController(ref);
});
