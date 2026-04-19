import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final headOfBusDevDashboardAdapterProvider =
    FutureProvider<Result<HeadOfBusDevDashboardViewModel>>((ref) async {
      const route = 'HeadOfBusDev';
      const cacheKey = 'head_of_bus_dev_dashboard_corporate';
      final resilience = ref.read(resilienceServiceProvider);

      // Hardened concurrent orchestration: Standard Metrics + AI Forecasting
      final responses = await Future.wait([
        ref.watch(dashboardMetricsProvider(route).future),
        ref.watch(forecastingProvider(route).future),
      ]);

      final metricsResult = responses[0] as Result<DashboardMetrics>;
      final forecastingResult =
          responses[1] as Result<AIAnalyticsForecastingData?>;

      return metricsResult.fold(
        (metrics) {
          final forecasting = forecastingResult.fold((f) => f, (e) => null);
          final viewModel = HeadOfBusDevDashboardViewModel.fromDashboardMetrics(
            metrics,
            forecasting: forecasting,
          );

          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
          return Success(viewModel);
        },
        (error) {
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(HeadOfBusDevDashboardViewModel.fromJson(snapshot));
          }
          return Success(
            HeadOfBusDevDashboardViewModel.assemble(isOffline: true),
          );
        },
      );
    });
