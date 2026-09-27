import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QualityAssuranceDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  QualityAssuranceDashboardScreenState({required this.isLoading, this.error, required this.data});

  QualityAssuranceDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return QualityAssuranceDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class QualityAssuranceDashboardScreenController extends StateNotifier<QualityAssuranceDashboardScreenState> {
  final Ref ref;
  QualityAssuranceDashboardScreenController(this.ref) : super(QualityAssuranceDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/quality-assurance-dashboard');
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

final quality_assurance_dashboardControllerProvider = StateNotifierProvider<QualityAssuranceDashboardScreenController, QualityAssuranceDashboardScreenState>((ref) {
  return QualityAssuranceDashboardScreenController(ref);
});
