// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final regionalManagerUsaDashboardAdapterProvider =
    FutureProvider<Result<RegionalManagerUsaDashboardViewModel>>((ref) async {
      const route = 'RegionalManagerUsa';
      const cacheKey = 'regional_manager_usa_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel =
              RegionalManagerUsaDashboardViewModel.fromDashboardMetrics(
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
        'RegionalManagerUsa Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              RegionalManagerUsaDashboardViewModel.fromJson(snapshot as Map<String, dynamic>),
            );
          }
          return Success(
            RegionalManagerUsaDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

