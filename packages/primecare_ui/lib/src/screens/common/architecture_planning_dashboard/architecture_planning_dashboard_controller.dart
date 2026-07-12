import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchitecturePlanningDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ArchitecturePlanningDashboardState({required this.isLoading, this.error, required this.data});

  ArchitecturePlanningDashboardState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ArchitecturePlanningDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ArchitecturePlanningDashboardController extends StateNotifier<ArchitecturePlanningDashboardState> {
  ArchitecturePlanningDashboardController() : super(ArchitecturePlanningDashboardState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
      state = state.copyWith(
        isLoading: false,
        data: {
          'active_designs': 8,
          'pending_reviews': 3,
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

final architecturePlanningDashboardControllerProvider = StateNotifierProvider<ArchitecturePlanningDashboardController, ArchitecturePlanningDashboardState>((ref) {
  return ArchitecturePlanningDashboardController();
});
