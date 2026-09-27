import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  GeneralManagerDashboardScreenState({required this.isLoading, this.error, required this.data});

  GeneralManagerDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return GeneralManagerDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class GeneralManagerDashboardScreenController extends StateNotifier<GeneralManagerDashboardScreenState> {
  final Ref ref;
  GeneralManagerDashboardScreenController(this.ref) : super(GeneralManagerDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/business_development/roles/general_manager/dashboard');
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

final general_manager_dashboardControllerProvider = StateNotifierProvider<GeneralManagerDashboardScreenController, GeneralManagerDashboardScreenState>((ref) {
  return GeneralManagerDashboardScreenController(ref);
});
