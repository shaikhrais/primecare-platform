import 'package:flutter_core/flutter_core.dart';
import 'psw_dashboard_state.dart';

final pswDashboardControllerProvider =
    NotifierProvider<PswDashboardController, PswDashboardState>(() {
  return PswDashboardController();
});

class PswDashboardController extends Notifier<PswDashboardState> {
  @override
  PswDashboardState build() {
    _init();
    return const PswDashboardState();
  }

  void _init() {
    // Listen to the core providers
    ref.listen<AsyncValue<Result<PswDashboardData>>>(pswDashboardProvider, (previous, next) {
      final unwrapped = next.whenData((result) => result.fold(
        (data) => data,
        (error) => throw error, // Should be handled by UI error state
      ));
      state = state.copyWith(dashboardData: unwrapped);
    });

    ref.listen<AuthState>(authProvider, (previous, next) {
      state = state.copyWith(authState: AsyncValue.data(next));
    });
  }

  Future<void> refresh() async {
    state = state.copyWith(isSyncing: true);
    ref.invalidate(pswDashboardProvider);
    state = state.copyWith(isSyncing: false);
  }

  void toggleTask(String taskId) {
    // Logic to toggle task completion via PswService
  }
}
