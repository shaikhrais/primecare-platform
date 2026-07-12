import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CisoDashboardScreenState({required this.isLoading, this.error, required this.data});

  CisoDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CisoDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CisoDashboardScreenController extends StateNotifier<CisoDashboardScreenState> {
  final Ref ref;
  CisoDashboardScreenController(this.ref) : super(CisoDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/ciso/dashboard');
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

final ciso_dashboardControllerProvider = StateNotifierProvider<CisoDashboardScreenController, CisoDashboardScreenState>((ref) {
  return CisoDashboardScreenController(ref);
});
