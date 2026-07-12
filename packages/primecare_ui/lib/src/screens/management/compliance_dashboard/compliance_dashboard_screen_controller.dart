import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ComplianceDashboardScreenState({required this.isLoading, this.error, required this.data});

  ComplianceDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ComplianceDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ComplianceDashboardScreenController extends StateNotifier<ComplianceDashboardScreenState> {
  final Ref ref;
  ComplianceDashboardScreenController(this.ref) : super(ComplianceDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/compliance-dashboard');
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

final compliance_dashboardControllerProvider = StateNotifierProvider<ComplianceDashboardScreenController, ComplianceDashboardScreenState>((ref) {
  return ComplianceDashboardScreenController(ref);
});
