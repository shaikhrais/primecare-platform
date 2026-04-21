// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final communityOutreachDashboardAdapterProvider =
    FutureProvider<Result<CommunityOutreachDashboardViewModel>>((ref) async {
  const route = 'CommunityOutreach';
  const cacheKey = 'community_outreach_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel =
          CommunityOutreachDashboardViewModel.fromDashboardMetrics(metrics);
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
        'CommunityOutreach Metrics Logistics Fallback Triggered',
      );
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = CommunityOutreachDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(CommunityOutreachDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(
        CommunityOutreachDashboardViewModel.empty(isOfflineFallback: true),
      );
    },
  );
});

