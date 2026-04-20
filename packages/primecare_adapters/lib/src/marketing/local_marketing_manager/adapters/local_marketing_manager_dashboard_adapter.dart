import 'dart:async';
import 'package:primecare_core/primecare_core.dart';

final localMarketingManagerDashboardAdapterProvider =
    FutureProvider<Result<LocalMarketingManagerDashboardViewModel>>((ref) async {
  const route = 'LocalMarketingManager';
  const cacheKey = 'local_marketing_manager_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel =
          LocalMarketingManagerDashboardViewModel.fromDashboardMetrics(metrics);
      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(LocalMarketingManagerDashboardViewModel.fromJson(snapshot));
      }
      return Success(
        LocalMarketingManagerDashboardViewModel.assemble(isOffline: true),
      );
    },
  );
});
