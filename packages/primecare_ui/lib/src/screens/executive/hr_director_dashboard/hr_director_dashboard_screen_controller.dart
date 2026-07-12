import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HrDirectorDashboardScreenState({required this.isLoading, this.error, required this.data});

  HrDirectorDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HrDirectorDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HrDirectorDashboardScreenController extends StateNotifier<HrDirectorDashboardScreenState> {
  final Ref ref;
  HrDirectorDashboardScreenController(this.ref) : super(HrDirectorDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/hr_director/dashboard');
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

final hr_director_dashboardControllerProvider = StateNotifierProvider<HrDirectorDashboardScreenController, HrDirectorDashboardScreenState>((ref) {
  return HrDirectorDashboardScreenController(ref);
});
