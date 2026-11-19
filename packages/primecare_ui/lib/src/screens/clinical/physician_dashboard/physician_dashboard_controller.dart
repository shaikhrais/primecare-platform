import 'package:flutter_riverpod/legacy.dart';

class PhysicianDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PhysicianDashboardState({
    required this.isLoading,
    this.error,
    required this.data,
  });

  PhysicianDashboardState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return PhysicianDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PhysicianDashboardController
    extends StateNotifier<PhysicianDashboardState> {
  PhysicianDashboardController() : super(_unavailable());

  // No approved aggregate metrics read is wired for this dashboard.
  // Unavailable data must never become sample counts or a healthy status.
  static PhysicianDashboardState _unavailable() => PhysicianDashboardState(
    isLoading: false,
    error: 'workspace.unconnected',
    data: const {},
  );

  Future<void> loadDashboardData() async {
    state = _unavailable();
  }

  Future<void> syncData() => loadDashboardData();
}

final physicianDashboardControllerProvider =
    StateNotifierProvider<
      PhysicianDashboardController,
      PhysicianDashboardState
    >((ref) {
      return PhysicianDashboardController();
    });
