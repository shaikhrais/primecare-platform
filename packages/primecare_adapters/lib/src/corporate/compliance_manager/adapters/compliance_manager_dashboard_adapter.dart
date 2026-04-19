import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final complianceManagerDashboardAdapterProvider =
    FutureProvider<Result<ComplianceManagerDashboardViewModel>>((ref) async {
  const route = 'ComplianceManager';
  const cacheKey = 'compliance_manager_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel =
          ComplianceManagerDashboardViewModel.fromDashboardMetrics(metrics);
      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(ComplianceManagerDashboardViewModel.fromJson(snapshot));
      }
      return Success(
        ComplianceManagerDashboardViewModel.assemble(isOffline: true),
      );
    },
  );
});
