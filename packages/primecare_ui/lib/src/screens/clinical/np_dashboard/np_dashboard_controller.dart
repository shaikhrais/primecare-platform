import 'package:flutter_riverpod/legacy.dart';

class NpDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  NpDashboardState({required this.isLoading, this.error, required this.data});

  NpDashboardState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return NpDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class NpDashboardController extends StateNotifier<NpDashboardState> {
  NpDashboardController() : super(_unavailable());

  // No approved aggregate metrics read is wired for this dashboard.
  // Unavailable data must never become sample counts or a healthy status.
  static NpDashboardState _unavailable() => NpDashboardState(
    isLoading: false,
    error: 'workspace.unconnected',
    data: const {},
  );

  Future<void> loadDashboardData() async {
    state = _unavailable();
  }

  Future<void> syncData() => loadDashboardData();
}

final npDashboardControllerProvider =
    StateNotifierProvider<NpDashboardController, NpDashboardState>((ref) {
      return NpDashboardController();
    });
