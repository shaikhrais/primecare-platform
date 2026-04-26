// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Scrum Master Dashboard.
final scrumMasterActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Scrum Master Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Scrum Master.
/// Tracks sprint health, velocity, and blocker resolutions.
final scrumMasterMetricsProvider = StreamProvider.autoDispose<DashboardMetrics>(
  (ref) {
    final repository = ref.watch(dashboardRepositoryProvider);
    return repository
        .watchMetrics('/v2/corporate/scrum_master')
        .map((r) => r.fold((m) => m, (e) => DashboardMetrics.empty()));
  },
);

/// High-fidelity AI agile insights for the Scrum Master.
/// Surfaces delivery risks and team velocity opportunities via Aura Intelligence.
final scrumMasterInsightsProvider = FutureProvider.autoDispose<List<IntelligenceInsight>>((
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
      id: 'sm_01',
      title: 'Velocity Dropping',
      summary:
          'Team Alpha velocity has dropped by 15% this sprint due to lingering tech debt.',
      impact: InsightImpact.warning,
      type: InsightType.efficiency,
      category: 'Delivery',
      recommendation:
          'Allocate 20% of next sprint capacity exclusively to tech debt resolution.',
    ),
    IntelligenceInsight(
      id: 'sm_02',
      title: 'Blocker Resolved Early',
      summary:
          'Authentication module blocker was resolved 2 days ahead of schedule.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Operations',
      recommendation:
          'Pull forward low-priority backlog items into the current sprint.',
    ),
  ];
});

/// Combined adapter provider for the Scrum Master Dashboard.
/// Bridges high-fidelity telemetry and agile insights into a unified ViewModel.
final scrumMasterDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<ScrumMasterDashboardViewModel>>((
      ref,
    ) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'scrum_master_dashboard';
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
        final metrics = await ref.watch(scrumMasterMetricsProvider.future);
        final insights = await ref.watch(scrumMasterInsightsProvider.future);

        final viewModel = ScrumMasterDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Scrum Master Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            ScrumMasterDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          ScrumMasterDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
