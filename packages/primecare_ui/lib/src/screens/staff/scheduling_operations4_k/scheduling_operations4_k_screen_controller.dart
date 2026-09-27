import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulingOperations4KScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  SchedulingOperations4KScreenState({required this.isLoading, this.error, required this.data});

  SchedulingOperations4KScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return SchedulingOperations4KScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class SchedulingOperations4KScreenController extends StateNotifier<SchedulingOperations4KScreenState> {
  final Ref ref;
  SchedulingOperations4KScreenController(this.ref) : super(SchedulingOperations4KScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/scheduling-operations4-k');
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

final scheduling_operations4_kControllerProvider = StateNotifierProvider<SchedulingOperations4KScreenController, SchedulingOperations4KScreenState>((ref) {
  return SchedulingOperations4KScreenController(ref);
});
