import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorDispatchMapScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CoordinatorDispatchMapScreenState({required this.isLoading, this.error, required this.data});

  CoordinatorDispatchMapScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CoordinatorDispatchMapScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CoordinatorDispatchMapScreenController extends StateNotifier<CoordinatorDispatchMapScreenState> {
  final Ref ref;
  CoordinatorDispatchMapScreenController(this.ref) : super(CoordinatorDispatchMapScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/coordinator-dispatch-map');
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

final coordinator_dispatch_mapControllerProvider = StateNotifierProvider<CoordinatorDispatchMapScreenController, CoordinatorDispatchMapScreenState>((ref) {
  return CoordinatorDispatchMapScreenController(ref);
});
