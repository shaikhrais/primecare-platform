import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HswDashboardState({required this.isLoading, this.error, required this.data});

  HswDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HswDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HswDashboardController extends StateNotifier<HswDashboardState> {
  HswDashboardController() : super(HswDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_visits': 5,
          'completed_logs': 2,
          'status': 'normal'
        }
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final hswDashboardControllerProvider = StateNotifierProvider<HswDashboardController, HswDashboardState>((ref) {
  return HswDashboardController();
});
