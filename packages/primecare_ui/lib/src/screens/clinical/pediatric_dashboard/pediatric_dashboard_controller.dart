import 'package:flutter_riverpod/legacy.dart';

class PediatricDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PediatricDashboardState({
    required this.isLoading,
    this.error,
    required this.data,
  });

  PediatricDashboardState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return PediatricDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PediatricDashboardController
    extends StateNotifier<PediatricDashboardState> {
  PediatricDashboardController() : super(_unavailable());

  // No approved aggregate metrics read is wired for this dashboard.
  // Unavailable data must never become sample counts or a healthy status.
  static PediatricDashboardState _unavailable() => PediatricDashboardState(
    isLoading: false,
    error: 'workspace.unconnected',
    data: const {},
  );

  Future<void> loadDashboardData() async {
    state = _unavailable();
  }

  Future<void> syncData() => loadDashboardData();
}

final pediatricDashboardControllerProvider =
    StateNotifierProvider<
      PediatricDashboardController,
      PediatricDashboardState
    >((ref) {
      return PediatricDashboardController();
    });
