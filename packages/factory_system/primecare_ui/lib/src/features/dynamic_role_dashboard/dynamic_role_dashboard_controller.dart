import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final dynamicRoleDashboardAdapterProvider =
    StateNotifierProvider.family<
      DynamicRoleDashboardController,
      AsyncValue<Result<DynamicRoleDashboardScreenViewModel>>,
      String
    >((ref, role) {
      return DynamicRoleDashboardController(ref, role);
    });

class DynamicRoleDashboardController
    extends StateNotifier<AsyncValue<Result<DynamicRoleDashboardScreenViewModel>>> {
  final Ref ref;
  final String role;

  DynamicRoleDashboardController(this.ref, this.role)
    : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    // Listen to the family-based metrics provider to ensure hydration is reactive and testable
    ref.listen<AsyncValue<Result<DashboardMetrics>>>(
      dashboardMetricsProvider(role),
      (previous, next) {
        state = next.map(
          data:
              (data) => AsyncValue.data(
                data.value.map(
                  (metrics) => DynamicRoleDashboardScreenViewModel(
                    metrics: metrics,
                    insights: const [],
                  ),
                ),
              ),
          loading: (_) => const AsyncValue.loading(),
          error: (error) => AsyncValue.error(error.error, error.stackTrace),
        );
      },
      fireImmediately: true,
    );
  }

  Future<void> refresh() async {
    // Refreshing the underlying provider will trigger the listener
    ref.invalidate(dashboardMetricsProvider(role));
  }
}
