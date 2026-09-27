import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RegionalManagerUsaDashboardScreenState({required this.isLoading, this.error, required this.data});

  RegionalManagerUsaDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RegionalManagerUsaDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RegionalManagerUsaDashboardScreenController extends StateNotifier<RegionalManagerUsaDashboardScreenState> {
  final Ref ref;
  RegionalManagerUsaDashboardScreenController(this.ref) : super(RegionalManagerUsaDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/business_development/roles/regional_manager_usa/dashboard');
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

final regional_manager_usa_dashboardControllerProvider = StateNotifierProvider<RegionalManagerUsaDashboardScreenController, RegionalManagerUsaDashboardScreenState>((ref) {
  return RegionalManagerUsaDashboardScreenController(ref);
});
