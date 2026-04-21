// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final operationsManagerDashboardAdapterProvider =
    FutureProvider<Result<OperationsManagerDashboardViewModel>>((ref) async {
      const route = 'OperationsManager';
      const cacheKey = 'operations_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel =
              OperationsManagerDashboardViewModel.fromDashboardMetrics(
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
        'OperationsManager Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              OperationsManagerDashboardViewModel.fromJson(snapshot),
            );
          }
          return Success(
            OperationsManagerDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

