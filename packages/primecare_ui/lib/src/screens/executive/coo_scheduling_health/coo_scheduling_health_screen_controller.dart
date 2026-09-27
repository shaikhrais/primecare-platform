import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooSchedulingHealthScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CooSchedulingHealthScreenState({required this.isLoading, this.error, required this.data});

  CooSchedulingHealthScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CooSchedulingHealthScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CooSchedulingHealthScreenController extends StateNotifier<CooSchedulingHealthScreenState> {
  final Ref ref;
  CooSchedulingHealthScreenController(this.ref) : super(CooSchedulingHealthScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/coo/scheduling-health');
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

final coo_scheduling_healthControllerProvider = StateNotifierProvider<CooSchedulingHealthScreenController, CooSchedulingHealthScreenState>((ref) {
  return CooSchedulingHealthScreenController(ref);
});
