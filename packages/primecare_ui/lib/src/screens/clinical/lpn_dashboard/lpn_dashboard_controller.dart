import 'package:flutter_riverpod/legacy.dart';

class LpnDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  LpnDashboardState({required this.isLoading, this.error, required this.data});

  LpnDashboardState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return LpnDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class LpnDashboardController extends StateNotifier<LpnDashboardState> {
  LpnDashboardController() : super(_unavailable());

  // No approved aggregate metrics read is wired for this dashboard.
  // Unavailable data must never become sample counts or a healthy status.
  static LpnDashboardState _unavailable() => LpnDashboardState(
    isLoading: false,
    error: 'workspace.unconnected',
    data: const {},
  );

  Future<void> loadDashboardData() async {
    state = _unavailable();
  }

  Future<void> syncData() => loadDashboardData();
}

final lpnDashboardControllerProvider =
    StateNotifierProvider<LpnDashboardController, LpnDashboardState>((ref) {
      return LpnDashboardController();
    });
