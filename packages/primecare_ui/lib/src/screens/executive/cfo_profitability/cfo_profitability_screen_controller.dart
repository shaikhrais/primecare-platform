import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoProfitabilityScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CfoProfitabilityScreenState({required this.isLoading, this.error, required this.data});

  CfoProfitabilityScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CfoProfitabilityScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CfoProfitabilityScreenController extends StateNotifier<CfoProfitabilityScreenState> {
  final Ref ref;
  CfoProfitabilityScreenController(this.ref) : super(CfoProfitabilityScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/cfo/profitability');
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

final cfo_profitabilityControllerProvider = StateNotifierProvider<CfoProfitabilityScreenController, CfoProfitabilityScreenState>((ref) {
  return CfoProfitabilityScreenController(ref);
});
