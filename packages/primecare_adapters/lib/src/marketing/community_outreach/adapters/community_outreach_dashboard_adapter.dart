import 'dart:async';
import 'package:primecare_core/primecare_core.dart';

final communityOutreachDashboardAdapterProvider =
    FutureProvider<Result<CommunityOutreachDashboardViewModel>>((ref) async {
  const route = 'CommunityOutreach';
  const cacheKey = 'community_outreach_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel =
          CommunityOutreachDashboardViewModel.fromDashboardMetrics(metrics);
      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(CommunityOutreachDashboardViewModel.fromJson(snapshot));
      }
      return Success(
        CommunityOutreachDashboardViewModel.assemble(isOffline: true),
      );
    },
  );
});
