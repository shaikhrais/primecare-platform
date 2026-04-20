import 'dart:async';
import 'package:primecare_core/primecare_core.dart';

final familyDashboardAdapterProvider =
    FutureProvider<Result<FamilyDashboardViewModel>>((ref) async {
  const route = 'FamilyMember';
  const cacheKey = 'family_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel = FamilyDashboardViewModel.fromDashboardMetrics(metrics);
      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(FamilyDashboardViewModel.fromJson(snapshot));
      }
      return Success(FamilyDashboardViewModel.assemble(isOffline: true));
    },
  );
});
