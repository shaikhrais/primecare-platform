import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClinicalAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  ClinicalAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClinicalAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClinicalAnalyticsScreenController extends StateNotifier<ClinicalAnalyticsScreenState> {
  final Ref ref;
  ClinicalAnalyticsScreenController(this.ref) : super(ClinicalAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/clinical_director/analytics');
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

final clinical_analyticsControllerProvider = StateNotifierProvider<ClinicalAnalyticsScreenController, ClinicalAnalyticsScreenState>((ref) {
  return ClinicalAnalyticsScreenController(ref);
});
