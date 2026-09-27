import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LpnDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  LpnDashboardState({required this.isLoading, this.error, required this.data});

  LpnDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return LpnDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class LpnDashboardController extends StateNotifier<LpnDashboardState> {
  LpnDashboardController() : super(LpnDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_patients': 10,
          'completed_treatments': 6,
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

final lpnDashboardControllerProvider = StateNotifierProvider<LpnDashboardController, LpnDashboardState>((ref) {
  return LpnDashboardController();
});
