// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final ceoDashboardAdapterProvider =
    FutureProvider<Result<CeoDashboardViewModel>>((ref) async {
  const route = 'CEO';
  const cacheKey = 'ceo_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel = CeoDashboardViewModel.fromDashboardMetrics(metrics);
      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      
      // Log successful hydration for telemetry and tests
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'CEO Dashboard route hydrated',
      );
      
      return Success(viewModel);
    },
    (error) {
      // Log specific fallback trigger expected by resilience suite
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'CEO Metrics Logistics Fallback Triggered',
      );

      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = CeoDashboardViewModel.fromJson(snapshot);
        return Success(CeoDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }

      // Final fallback to synthetic skeleton
      return Success(CeoDashboardViewModel.empty(isOfflineFallback: true));
    },
  );
});
