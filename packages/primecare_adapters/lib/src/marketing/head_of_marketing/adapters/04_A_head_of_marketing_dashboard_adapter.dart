// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final headOfMarketingDashboardAdapterProvider =
    FutureProvider<Result<HeadOfMarketingDashboardViewModel>>((ref) async {
      const route = 'HeadOfMarketing';
      const cacheKey = 'head_of_marketing_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel =
              HeadOfMarketingDashboardViewModel.fromDashboardMetrics(
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
        'HeadOfMarketing Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              HeadOfMarketingDashboardViewModel.fromJson(snapshot as Map<String, dynamic>),
            );
          }
          return Success(
            HeadOfMarketingDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

