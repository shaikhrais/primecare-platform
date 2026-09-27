import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CnsDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CnsDashboardState({required this.isLoading, this.error, required this.data});

  CnsDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CnsDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CnsDashboardController extends StateNotifier<CnsDashboardState> {
  CnsDashboardController() : super(CnsDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_consults': 12,
          'pending_approvals': 4,
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

final cnsDashboardControllerProvider = StateNotifierProvider<CnsDashboardController, CnsDashboardState>((ref) {
  return CnsDashboardController();
});
