import 'dart:async';
import 'package:primecare_core/primecare_core.dart';

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
        // Force offline flag to true for cached data
        return Success(CeoDashboardViewModel(
          isOfflineFallback: true,
          kpis: vm.kpis,
          recentActivity: vm.recentActivity,
          blueprints: vm.blueprints,
        ));
      }

      // Final fallback to synthetic skeleton
      return Success(CeoDashboardViewModel.assemble(isOffline: true));
    },
  );
});
