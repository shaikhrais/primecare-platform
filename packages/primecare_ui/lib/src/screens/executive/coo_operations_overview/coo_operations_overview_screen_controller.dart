import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooOperationsOverviewScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CooOperationsOverviewScreenState({required this.isLoading, this.error, required this.data});

  CooOperationsOverviewScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CooOperationsOverviewScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CooOperationsOverviewScreenController extends StateNotifier<CooOperationsOverviewScreenState> {
  final Ref ref;
  CooOperationsOverviewScreenController(this.ref) : super(CooOperationsOverviewScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/coo/operations-overview');
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

final coo_operations_overviewControllerProvider = StateNotifierProvider<CooOperationsOverviewScreenController, CooOperationsOverviewScreenState>((ref) {
  return CooOperationsOverviewScreenController(ref);
});
