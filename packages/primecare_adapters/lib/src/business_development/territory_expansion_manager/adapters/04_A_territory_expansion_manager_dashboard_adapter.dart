// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final territoryExpansionManagerDashboardAdapterProvider =
    FutureProvider<Result<TerritoryExpansionManagerDashboardViewModel>>((
      ref,
    ) async {
      const route = 'TerritoryExpansionManager';
      const cacheKey = 'territory_expansion_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel =
              TerritoryExpansionManagerDashboardViewModel.fromDashboardMetrics(
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
        'TerritoryExpansionManager Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              TerritoryExpansionManagerDashboardViewModel.fromJson(snapshot),
            );
          }
          return Success(
            TerritoryExpansionManagerDashboardViewModel.empty(
              isOfflineFallback: true,
            ),
          );
        },
      );
    });

