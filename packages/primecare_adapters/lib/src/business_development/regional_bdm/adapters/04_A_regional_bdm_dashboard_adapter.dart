// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final regionalBdmDashboardAdapterProvider =
    FutureProvider<Result<RegionalBdmDashboardViewModel>>((
      ref,
    ) async {
      const route = 'RegionalBdm';
      const cacheKey = 'regional_bdm_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
          final viewModel = RegionalBdmDashboardViewModel.fromDashboardMetrics(
            metrics,
          );
          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

          telemetry.passGate(
            ExecutionGateCategory.resilience,
            'BDM Dashboard route hydrated',
          );
          return Success(viewModel);
        },
        (error) {
          telemetry.passGate(
            ExecutionGateCategory.resilience,
            'Regional BDM Metrics Logistics Fallback Triggered',
          );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              RegionalBdmDashboardViewModel.fromJson(snapshot),
            );
          }
          return Success(
            RegionalBdmDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });
