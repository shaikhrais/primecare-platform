import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorHubScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CoordinatorHubScreenState({required this.isLoading, this.error, required this.data});

  CoordinatorHubScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CoordinatorHubScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CoordinatorHubScreenController extends StateNotifier<CoordinatorHubScreenState> {
  final Ref ref;
  CoordinatorHubScreenController(this.ref) : super(CoordinatorHubScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/coordinator-hub');
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

final coordinator_hubControllerProvider = StateNotifierProvider<CoordinatorHubScreenController, CoordinatorHubScreenState>((ref) {
  return CoordinatorHubScreenController(ref);
});
