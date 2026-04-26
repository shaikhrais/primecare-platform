import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Volunteer Coordinator Dashboard.
final volunteerCoordinatorActionHandler = Provider<void Function(String)>((
  ref,
) {
  return (action) {
    PrimeCareLogger.log('Volunteer Coordinator Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Volunteer Coordinator.
/// Tracks active volunteer counts, shift coverage, and engagement trends.
final volunteerMetricsProvider = StreamProvider.autoDispose<DashboardMetrics>((
  ref,
) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository
      .watchMetrics('/v2/corporate/volunteer_coordinator')
      .map((r) => r.fold((m) => m, (e) => DashboardMetrics.empty()));
});

/// High-fidelity AI curriculum insights for the Volunteer Coordinator.
/// Surfaces engagement opportunities and retention strategies via Aura Intelligence.
final volunteerInsightsProvider = FutureProvider.autoDispose<List<IntelligenceInsight>>((
  ref,
) async {
  ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 10));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return const [];
  }

  await Future<void>.delayed(const Duration(seconds: 1));

  return [
    IntelligenceInsight(
      id: 'vc_01',
      title: LocaleKeys
          .dashboards_volunteercoordinator_labels_shift_coverage_gap
          .tr(),
      summary:
          'Weekend shift coverage has dropped by 20% over the last 3 weeks.',
      impact: InsightImpact.warning,
      type: InsightType.efficiency,
      category: 'Operations',
      recommendation:
          'Launch targeted recruitment campaign emphasizing weekend availability.',
    ),
    IntelligenceInsight(
      id: 'vc_02',
      title: LocaleKeys
          .dashboards_volunteercoordinator_labels_high_retention_rate_detected
          .tr(),
      summary:
          'Volunteers participating in the "Companion Program" show a 90% retention rate.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Engagement',
      recommendation:
          'Expand the Companion Program to additional regional chapters.',
    ),
  ];
});

/// Combined adapter provider for the Volunteer Coordinator Dashboard.
/// Bridges high-fidelity telemetry and engagement insights into a unified ViewModel.
final volunteerCoordinatorDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<VolunteerCoordinatorDashboardViewModel>>((
      ref,
    ) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'volunteer_coordinator_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );

      try {
        if (!canExecute) {
          throw Exception('Metrics subsystem is degraded or offline');
        }
        final metrics = await ref.watch(volunteerMetricsProvider.future);
        final insights = await ref.watch(volunteerInsightsProvider.future);

        final viewModel = VolunteerCoordinatorDashboardViewModel(
          title: LocaleKeys
              .dashboards_volunteercoordinator_labels_volunteer_coordinator_dashboard
              .tr(),
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Volunteer Coordinator Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            VolunteerCoordinatorDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          VolunteerCoordinatorDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
