import 'package:flutter_riverpod/legacy.dart';

class HswDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HswDashboardState({required this.isLoading, this.error, required this.data});

  HswDashboardState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return HswDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HswDashboardController extends StateNotifier<HswDashboardState> {
  HswDashboardController() : super(_unavailable());

  // No approved aggregate metrics read is wired for this dashboard.
  // Unavailable data must never become sample counts or a healthy status.
  static HswDashboardState _unavailable() => HswDashboardState(
    isLoading: false,
    error: 'workspace.unconnected',
    data: const {},
  );

  Future<void> loadDashboardData() async {
    state = _unavailable();
  }

  Future<void> syncData() => loadDashboardData();
}

final hswDashboardControllerProvider =
    StateNotifierProvider<HswDashboardController, HswDashboardState>((ref) {
      return HswDashboardController();
    });
