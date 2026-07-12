import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropracticProgressTrackingScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ChiropracticProgressTrackingScreenState({required this.isLoading, this.error, required this.data});

  ChiropracticProgressTrackingScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ChiropracticProgressTrackingScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ChiropracticProgressTrackingScreenController extends StateNotifier<ChiropracticProgressTrackingScreenState> {
  final Ref ref;
  ChiropracticProgressTrackingScreenController(this.ref) : super(ChiropracticProgressTrackingScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/chiropractor/chiropractic-progress-tracking');
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

final chiropractic_progress_trackingControllerProvider = StateNotifierProvider<ChiropracticProgressTrackingScreenController, ChiropracticProgressTrackingScreenState>((ref) {
  return ChiropracticProgressTrackingScreenController(ref);
});
