// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final volunteerCoordinatorDashboardAdapterProvider =
    FutureProvider<Result<VolunteerCoordinatorDashboardViewModel>>((ref) async {
  const route = 'VolunteerCoordinator';
  const cacheKey = 'volunteer_coordinator_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

  return metricsResult.fold(
    (metrics) {
      final viewModel = VolunteerCoordinatorDashboardViewModel(
        title: 'Volunteer Network Command',
        metrics: metrics,
        insights: [],
      );

      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Volunteer Coordinator Dashboard hydrated',
      );
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Volunteer Coordinator Metrics Logistics Fallback Triggered',
      );
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(
          VolunteerCoordinatorDashboardViewModel.fromJson(snapshot),
        );
      }
      return Success(
        VolunteerCoordinatorDashboardViewModel(
          title: 'Volunteer Network Command',
          metrics: DashboardMetrics.empty(),
          insights: [],
          isOfflineFallback: true,
        ),
      );
    },
  );
});
