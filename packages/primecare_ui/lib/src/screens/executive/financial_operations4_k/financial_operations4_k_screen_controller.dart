import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancialOperations4KScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FinancialOperations4KScreenState({required this.isLoading, this.error, required this.data});

  FinancialOperations4KScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FinancialOperations4KScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FinancialOperations4KScreenController extends StateNotifier<FinancialOperations4KScreenState> {
  final Ref ref;
  FinancialOperations4KScreenController(this.ref) : super(FinancialOperations4KScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/financial-operations4-k');
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

final financial_operations4_kControllerProvider = StateNotifierProvider<FinancialOperations4KScreenController, FinancialOperations4KScreenState>((ref) {
  return FinancialOperations4KScreenController(ref);
});
