import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysicianDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PhysicianDashboardState({required this.isLoading, this.error, required this.data});

  PhysicianDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PhysicianDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PhysicianDashboardController extends StateNotifier<PhysicianDashboardState> {
  PhysicianDashboardController() : super(PhysicianDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_patients': 6,
          'pending_labs': 2,
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

final physicianDashboardControllerProvider = StateNotifierProvider<PhysicianDashboardController, PhysicianDashboardState>((ref) {
  return PhysicianDashboardController();
});
