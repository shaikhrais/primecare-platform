import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final trainingDirectorDashboardAdapterProvider =
    FutureProvider<Result<TrainingDirectorDashboardViewModel>>((ref) async {
  const route = 'TrainingDirector';
  const cacheKey = 'training_director_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel =
          TrainingDirectorDashboardViewModel.fromDashboardMetrics(metrics);
      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(TrainingDirectorDashboardViewModel.fromJson(snapshot));
      }
      return Success(
        TrainingDirectorDashboardViewModel.assemble(isOffline: true),
      );
    },
  );
});
