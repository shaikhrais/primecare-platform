// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final cooDashboardAdapterProvider = FutureProvider<Result<CooDashboardViewModel>>((
  ref,
) async {
  const route = 'COO';
  const cacheKey = 'coo_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

  return metricsResult.fold(
    (metrics) {
      // High-Fidelity Mapping: Combine native metrics with AI intelligence
            final viewModel = CooDashboardViewModel.fromDashboardMetrics(
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
        'Coo Metrics Logistics Fallback Triggered',
      );
      // Resilience Logic: Restore from local snapshot if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = CooDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(CooDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(CooDashboardViewModel.empty(isOfflineFallback: true));
    },
  );
});

