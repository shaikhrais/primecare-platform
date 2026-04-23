// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final humanResourcesDirectorDashboardAdapterProvider =
    FutureProvider<Result<HumanResourcesDirectorDashboardViewModel>>((ref) async {
  const route = 'HumanResourcesDirector';
  const cacheKey = 'hr_director_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

  return metricsResult.fold(
    (metrics) {
      final viewModel = HumanResourcesDirectorDashboardViewModel(
        title: 'HR Director Command',
        metrics: metrics,
        insights: [], // Will be hydrated by AuraIntelligence if enabled
      );

      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'HR Director Dashboard hydrated',
      );
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'HR Director Metrics Logistics Fallback Triggered',
      );
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(
          HumanResourcesDirectorDashboardViewModel.fromJson(snapshot),
        );
      }
      return Success(
        HumanResourcesDirectorDashboardViewModel(
          title: 'HR Director Command',
          metrics: DashboardMetrics.empty(),
          insights: [],
          isOfflineFallback: true,
        ),
      );
    },
  );
});
