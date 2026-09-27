import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RnDashboardScreenState({required this.isLoading, this.error, required this.data});

  RnDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RnDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RnDashboardScreenController extends StateNotifier<RnDashboardScreenState> {
  final Ref ref;
  RnDashboardScreenController(this.ref) : super(RnDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rn/dashboard');
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

final rn_dashboardControllerProvider = StateNotifierProvider<RnDashboardScreenController, RnDashboardScreenState>((ref) {
  return RnDashboardScreenController(ref);
});
