import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final cooDashboardAdapterProvider = FutureProvider<Result<CooDashboardViewModel>>((
  ref,
) async {
  const route = 'COO';
  const cacheKey = 'coo_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  // Hardening Logic: Concurrently fetch standard metrics and AI Analytics forecasting
  final results = await Future.wait([
    ref.watch(dashboardMetricsProvider(route).future),
    ref.watch(aiAnalyticsForecastingProvider.future),
  ]);

  final metricsResult = results[0] as Result<DashboardMetrics>;
  final aiResult = results[1] as Result<AIAnalyticsForecastingData>;

  return metricsResult.fold(
    (metrics) {
      // High-Fidelity Mapping: Combine native metrics with AI intelligence
      final forecasting = aiResult.fold((data) => data, (err) => null);
      final viewModel = CooDashboardViewModel.fromDashboardMetrics(
        metrics,
        forecasting: forecasting,
      );

      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Resilience Logic: Restore from local snapshot if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(CooDashboardViewModel.fromJson(snapshot));
      }
      return Success(CooDashboardViewModel.assemble(isOffline: true));
    },
  );
});
