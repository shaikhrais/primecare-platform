import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RmtDashboardState({required this.isLoading, this.error, required this.data});

  RmtDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RmtDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RmtDashboardController extends StateNotifier<RmtDashboardState> {
  RmtDashboardController() : super(RmtDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_patients': 8,
          'pending_notes': 2,
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

final rmtDashboardControllerProvider = StateNotifierProvider<RmtDashboardController, RmtDashboardState>((ref) {
  return RmtDashboardController();
});
