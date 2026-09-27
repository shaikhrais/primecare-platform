import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoRevenueScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CfoRevenueScreenState({required this.isLoading, this.error, required this.data});

  CfoRevenueScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CfoRevenueScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CfoRevenueScreenController extends StateNotifier<CfoRevenueScreenState> {
  final Ref ref;
  CfoRevenueScreenController(this.ref) : super(CfoRevenueScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/cfo/revenue');
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

final cfo_revenueControllerProvider = StateNotifierProvider<CfoRevenueScreenController, CfoRevenueScreenState>((ref) {
  return CfoRevenueScreenController(ref);
});
