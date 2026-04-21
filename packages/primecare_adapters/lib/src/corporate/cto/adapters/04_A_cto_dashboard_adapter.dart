// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final ctoDashboardAdapterProvider = FutureProvider<Result<CtoDashboardViewModel>>((
  ref,
) async {
  const route = 'CTO';
  const cacheKey = 'cto_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

  return metricsResult.fold(
    (metrics) {
      // High-Fidelity Mapping: Combine native metrics with AI intelligence
            final viewModel = CtoDashboardViewModel.fromDashboardMetrics(
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
        'Cto Metrics Logistics Fallback Triggered',
      );
      // Resilience Logic: Restore from local snapshot if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = CtoDashboardViewModel.fromJson(snapshot);
        return Success(CtoDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(CtoDashboardViewModel.empty(isOfflineFallback: true));
    },
  );
});

