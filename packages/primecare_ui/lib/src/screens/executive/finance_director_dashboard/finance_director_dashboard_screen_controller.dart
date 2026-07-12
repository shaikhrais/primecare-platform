import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FinanceDirectorDashboardScreenState({required this.isLoading, this.error, required this.data});

  FinanceDirectorDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FinanceDirectorDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FinanceDirectorDashboardScreenController extends StateNotifier<FinanceDirectorDashboardScreenState> {
  final Ref ref;
  FinanceDirectorDashboardScreenController(this.ref) : super(FinanceDirectorDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/finance_director/dashboard');
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

final finance_director_dashboardControllerProvider = StateNotifierProvider<FinanceDirectorDashboardScreenController, FinanceDirectorDashboardScreenState>((ref) {
  return FinanceDirectorDashboardScreenController(ref);
});
