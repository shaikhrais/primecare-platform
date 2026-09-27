import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PediatricDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PediatricDashboardState({required this.isLoading, this.error, required this.data});

  PediatricDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PediatricDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PediatricDashboardController extends StateNotifier<PediatricDashboardState> {
  PediatricDashboardController() : super(PediatricDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_patients': 15,
          'completed_immunizations': 8,
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

final pediatricDashboardControllerProvider = StateNotifierProvider<PediatricDashboardController, PediatricDashboardState>((ref) {
  return PediatricDashboardController();
});
