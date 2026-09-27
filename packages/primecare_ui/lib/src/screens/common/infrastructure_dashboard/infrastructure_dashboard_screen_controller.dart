import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  InfrastructureDashboardScreenState({required this.isLoading, this.error, required this.data});

  InfrastructureDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return InfrastructureDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class InfrastructureDashboardScreenController extends StateNotifier<InfrastructureDashboardScreenState> {
  final Ref ref;
  InfrastructureDashboardScreenController(this.ref) : super(InfrastructureDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/infrastructure-dashboard');
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

final infrastructure_dashboardControllerProvider = StateNotifierProvider<InfrastructureDashboardScreenController, InfrastructureDashboardScreenState>((ref) {
  return InfrastructureDashboardScreenController(ref);
});
