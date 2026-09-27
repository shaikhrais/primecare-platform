import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NpDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  NpDashboardState({required this.isLoading, this.error, required this.data});

  NpDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return NpDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class NpDashboardController extends StateNotifier<NpDashboardState> {
  NpDashboardController() : super(NpDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_cases': 14,
          'pending_prescriptions': 3,
          'avg_triage_time': '12 mins',
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

final npDashboardControllerProvider = StateNotifierProvider<NpDashboardController, NpDashboardState>((ref) {
  return NpDashboardController();
});
