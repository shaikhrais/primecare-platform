import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final regionalManagerOntarioDashboardAdapterProvider =
    FutureProvider<Result<RegionalManagerOntarioDashboardViewModel>>((
      ref,
    ) async {
      const route = 'RegionalManagerOntario';
      const cacheKey = 'regional_manager_ontario_dashboard';
      final resilience = ref.read(resilienceServiceProvider);

      // High-performance concurrent fetch for metrics and AI analytics
      final results = await Future.wait([
        ref.watch(dashboardMetricsProvider(route).future),
        ref.watch(aiAnalyticsForecastingProvider.future),
      ]);

      final metricsResult = results[0] as Result<DashboardMetrics>;
      final aiResult = results[1] as Result<AIAnalyticsForecastingData>;

      return metricsResult.fold(
        (metrics) {
          final forecasting = aiResult.fold((data) => data, (err) => null);
          final viewModel = PrimeCareDashboardViewModel.fromDashboardMetrics(
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
            return Success(
              RegionalManagerOntarioDashboardViewModel.fromJson(snapshot),
            );
          }
          return Success(
            RegionalManagerOntarioDashboardViewModel.assemble(isOffline: true),
          );
        },
      );
    });
