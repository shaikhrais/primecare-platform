import 'package:flutter_riverpod/legacy.dart';

class CnsDashboardState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CnsDashboardState({required this.isLoading, this.error, required this.data});

  CnsDashboardState copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return CnsDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CnsDashboardController extends StateNotifier<CnsDashboardState> {
  CnsDashboardController() : super(_unavailable());

  // No approved aggregate metrics read is wired for this dashboard.
  // Unavailable data must never become sample counts or a healthy status.
  static CnsDashboardState _unavailable() => CnsDashboardState(
    isLoading: false,
    error: 'workspace.unconnected',
    data: const {},
  );

  Future<void> loadDashboardData() async {
    state = _unavailable();
  }

  Future<void> syncData() => loadDashboardData();
}

final cnsDashboardControllerProvider =
    StateNotifierProvider<CnsDashboardController, CnsDashboardState>((ref) {
      return CnsDashboardController();
    });
