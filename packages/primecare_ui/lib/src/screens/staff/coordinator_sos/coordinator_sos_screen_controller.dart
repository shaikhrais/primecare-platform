import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorSosScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CoordinatorSosScreenState({required this.isLoading, this.error, required this.data});

  CoordinatorSosScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CoordinatorSosScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CoordinatorSosScreenController extends StateNotifier<CoordinatorSosScreenState> {
  final Ref ref;
  CoordinatorSosScreenController(this.ref) : super(CoordinatorSosScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/coordinator-sos');
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

final coordinator_sosControllerProvider = StateNotifierProvider<CoordinatorSosScreenController, CoordinatorSosScreenState>((ref) {
  return CoordinatorSosScreenController(ref);
});
