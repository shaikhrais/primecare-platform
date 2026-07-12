import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyOperationsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  DailyOperationsScreenState({required this.isLoading, this.error, required this.data});

  DailyOperationsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return DailyOperationsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class DailyOperationsScreenController extends StateNotifier<DailyOperationsScreenState> {
  final Ref ref;
  DailyOperationsScreenController(this.ref) : super(DailyOperationsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/daily-operations');
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

final daily_operationsControllerProvider = StateNotifierProvider<DailyOperationsScreenController, DailyOperationsScreenState>((ref) {
  return DailyOperationsScreenController(ref);
});
