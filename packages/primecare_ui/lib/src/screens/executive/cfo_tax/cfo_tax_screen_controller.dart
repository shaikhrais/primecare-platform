import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoTaxScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CfoTaxScreenState({required this.isLoading, this.error, required this.data});

  CfoTaxScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CfoTaxScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CfoTaxScreenController extends StateNotifier<CfoTaxScreenState> {
  final Ref ref;
  CfoTaxScreenController(this.ref) : super(CfoTaxScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/cfo-tax');
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

final cfo_taxControllerProvider = StateNotifierProvider<CfoTaxScreenController, CfoTaxScreenState>((ref) {
  return CfoTaxScreenController(ref);
});
