// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final territorySalesManagerDashboardAdapterProvider =
    FutureProvider<Result<TerritorySalesManagerDashboardViewModel>>((ref) async {
  const route = 'TerritorySalesManager';
  const cacheKey = 'territory_sales_manager_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel =
          TerritorySalesManagerDashboardViewModel.fromDashboardMetrics(metrics);
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
        'TerritorySalesManager Metrics Logistics Fallback Triggered',
      );
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = TerritorySalesManagerDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(TerritorySalesManagerDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(
        TerritorySalesManagerDashboardViewModel.empty(isOfflineFallback: true),
      );
    },
  );
});

