// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final franchiseSalesManagerDashboardAdapterProvider =
    FutureProvider<Result<FranchiseSalesManagerDashboardViewModel>>((
      ref,
    ) async {
      const route = 'FranchiseSalesManager';
      const cacheKey = 'franchise_sales_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel =
              FranchiseSalesManagerDashboardViewModel.fromDashboardMetrics(
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
        'FranchiseSalesManager Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              FranchiseSalesManagerDashboardViewModel.fromJson(snapshot as Map<String, dynamic>),
            );
          }
          return Success(
            FranchiseSalesManagerDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

