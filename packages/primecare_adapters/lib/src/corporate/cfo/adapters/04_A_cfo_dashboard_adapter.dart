// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final cfoDashboardAdapterProvider = FutureProvider<Result<CfoDashboardViewModel>>((
  ref,
) async {
  const route = 'CFO';
  const cacheKey = 'cfo_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

  return metricsResult.fold(
    (metrics) {
      // High-Fidelity Mapping: Combine native metrics with AI intelligence
            final viewModel = CfoDashboardViewModel.fromDashboardMetrics(
        metrics,
      );

      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Dashboard route hydrated',
      );
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Cfo Metrics Logistics Fallback Triggered',
      );
      // Resilience Logic: Restore from local snapshot if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = CfoDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(CfoDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(CfoDashboardViewModel.empty(isOfflineFallback: true));
    },
  );
});

