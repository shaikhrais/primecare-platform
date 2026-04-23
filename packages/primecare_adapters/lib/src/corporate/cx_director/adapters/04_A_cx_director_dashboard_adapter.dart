// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final customerExperienceDirectorDashboardAdapterProvider =
    FutureProvider<Result<CustomerExperienceDirectorDashboardViewModel>>((ref) async {
  const route = 'CustomerExperienceDirector';
  const cacheKey = 'cx_director_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

  return metricsResult.fold(
    (metrics) {
      final viewModel = CustomerExperienceDirectorDashboardViewModel(
        title: 'CX Director Command',
        metrics: metrics,
        insights: [],
      );

      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'CX Director Dashboard hydrated',
      );
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'CX Director Metrics Logistics Fallback Triggered',
      );
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(
          CustomerExperienceDirectorDashboardViewModel.fromJson(snapshot),
        );
      }
      return Success(
        CustomerExperienceDirectorDashboardViewModel(
          title: 'CX Director Command',
          metrics: DashboardMetrics.empty(),
          insights: [],
          isOfflineFallback: true,
        ),
      );
    },
  );
});
