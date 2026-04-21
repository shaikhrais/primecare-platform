// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final regionalManagerOntarioDashboardAdapterProvider =
    FutureProvider<Result<RegionalManagerOntarioDashboardViewModel>>((
      ref,
    ) async {
      const route = 'RegionalManagerOntario';
      const cacheKey = 'regional_manager_ontario_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel = RegionalManagerOntarioDashboardViewModel.fromDashboardMetrics(
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
        'RegionalManagerOntario Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              RegionalManagerOntarioDashboardViewModel.fromJson(snapshot),
            );
          }
          return Success(
            RegionalManagerOntarioDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

