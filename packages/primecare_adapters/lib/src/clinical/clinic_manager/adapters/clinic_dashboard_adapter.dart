import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final clinicDashboardAdapterProvider =
    FutureProvider<Result<ClinicDashboardViewModel>>((ref) async {
      const route = 'ClinicManager';
      const cacheKey = 'clinic_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);

      // Concurrently fetch primary metrics and AI forecasting for high performance
      final results = await Future.wait([
        ref.watch(dashboardMetricsProvider(route).future),
        ref.watch(aiAnalyticsForecastingProvider.future),
      ]);

      final metricsResult = results[0] as Result<DashboardMetrics>;
      final forecastingResult =
          results[1] as Result<AIAnalyticsForecastingData>;

      return metricsResult.fold(
        (metrics) {
          final forecasting = forecastingResult.fold(
            (data) => data,
            (_) => null, // If forecasting fails, we still show the metrics
          );

          final viewModel = ClinicDashboardViewModel.fromDashboardMetrics(
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
            return Success(ClinicDashboardViewModel.fromJson(snapshot));
          }
          return Success(ClinicDashboardViewModel.assemble(isOffline: true));
        },
      );
    });
