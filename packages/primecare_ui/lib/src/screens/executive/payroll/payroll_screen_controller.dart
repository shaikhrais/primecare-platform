import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayrollScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PayrollScreenState({required this.isLoading, this.error, required this.data});

  PayrollScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PayrollScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PayrollScreenController extends StateNotifier<PayrollScreenState> {
  final Ref ref;
  PayrollScreenController(this.ref) : super(PayrollScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/payroll');
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

final payrollControllerProvider = StateNotifierProvider<PayrollScreenController, PayrollScreenState>((ref) {
  return PayrollScreenController(ref);
});
