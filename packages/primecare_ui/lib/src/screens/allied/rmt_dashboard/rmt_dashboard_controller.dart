import 'package:flutter_riverpod/legacy.dart';

class RmtDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RmtDashboardState({required this.isLoading, this.error, required this.data});

  RmtDashboardState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return RmtDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RmtDashboardController extends StateNotifier<RmtDashboardState> {
  RmtDashboardController() : super(_unavailable());

  // No approved aggregate metrics read is wired for this dashboard.
  // Unavailable data must never become sample counts or a healthy status.
  static RmtDashboardState _unavailable() => RmtDashboardState(
    isLoading: false,
    error: 'workspace.unconnected',
    data: const {},
  );

  Future<void> loadDashboardData() async {
    state = _unavailable();
  }

  Future<void> syncData() => loadDashboardData();
}

final rmtDashboardControllerProvider =
    StateNotifierProvider<RmtDashboardController, RmtDashboardState>((ref) {
      return RmtDashboardController();
    });
