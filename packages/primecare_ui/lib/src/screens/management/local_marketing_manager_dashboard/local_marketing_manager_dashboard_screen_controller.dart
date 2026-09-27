import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  LocalMarketingManagerDashboardScreenState({required this.isLoading, this.error, required this.data});

  LocalMarketingManagerDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return LocalMarketingManagerDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class LocalMarketingManagerDashboardScreenController extends StateNotifier<LocalMarketingManagerDashboardScreenState> {
  final Ref ref;
  LocalMarketingManagerDashboardScreenController(this.ref) : super(LocalMarketingManagerDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/marketing/roles/local_marketing_manager/dashboard');
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

final local_marketing_manager_dashboardControllerProvider = StateNotifierProvider<LocalMarketingManagerDashboardScreenController, LocalMarketingManagerDashboardScreenState>((ref) {
  return LocalMarketingManagerDashboardScreenController(ref);
});
