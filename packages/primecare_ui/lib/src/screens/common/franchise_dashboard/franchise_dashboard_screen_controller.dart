import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FranchiseDashboardScreenState({required this.isLoading, this.error, required this.data});

  FranchiseDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FranchiseDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FranchiseDashboardScreenController extends StateNotifier<FranchiseDashboardScreenState> {
  final Ref ref;
  FranchiseDashboardScreenController(this.ref) : super(FranchiseDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/franchise-dashboard');
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

final franchise_dashboardControllerProvider = StateNotifierProvider<FranchiseDashboardScreenController, FranchiseDashboardScreenState>((ref) {
  return FranchiseDashboardScreenController(ref);
});
