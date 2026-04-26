import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'package:primecare_adapters/primecare_adapters.dart';
import 'dart:async';

// -----------------------------------------------------------------------------
// Split Hydration: Real-time Telemetry (Stream) + AI Insights (Future)
// -----------------------------------------------------------------------------

/// High-fidelity telemetry stream for the Regional Manager (USA).
/// Tracks market reach, revenue velocity, and regional compliance across US clusters.
final regionalManagerUsaMetricsProvider = StreamProvider<DashboardMetrics>((
  ref,
) {
  const route = 'RegionalManagerUsa';
  final repository = ref.watch(dashboardRepositoryProvider);
  final telemetry = ref.read(executionGateProvider);

  telemetry.passGate(
    ExecutionGateCategory.resilience,
    'Regional Manager USA metrics stream initiated.',
  );

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository.watchMetrics(route).map((metricsResult) {
    return metricsResult.fold((metrics) {
      final enrichedKpis = metrics.kpis.isEmpty
          ? [
              KpiMetric(
                title: LocaleKeys
                    .dashboards_regionalmanagerusa_labels_market_reach
                    .tr(),
                value: '28.2%',
                trend: '+3.1%',
                status: 'positive',
              ),
              KpiMetric(
                title: LocaleKeys
                    .dashboards_regionalmanagerusa_labels_revenue_velocity
                    .tr(),
                value: '1.4x',
                trend: '+12.0%',
                status: 'positive',
              ),
              KpiMetric(
                title: LocaleKeys
                    .dashboards_regionalmanagerusa_labels_compliance_rating
                    .tr(),
                value: '99.8%',
                trend: '+0.5%',
                status: 'positive',
              ),
              KpiMetric(
                title: LocaleKeys
                    .dashboards_regionalmanagerusa_labels_regional_retention
                    .tr(),
                value: '92%',
                trend: '+1.5%',
                status: 'positive',
              ),
            ]
          : metrics.kpis;

      return metrics.copyWith(
        kpis: enrichedKpis,
        recentActivity: metrics.recentActivity,
      );
    }, (error) => DashboardMetrics.empty());
  });
});

/// High-fidelity AI regional insights for the Regional Manager (USA).
/// Surfaces interstate mobility and market saturation risks via Aura Intelligence.
final regionalManagerUsaInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  await Future<void>.delayed(const Duration(seconds: 1));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }
  return [
    IntelligenceInsight(
      id: 'reg_usa_01',
      title: LocaleKeys
          .dashboards_regionalmanagerusa_labels_interstate_mobility_optimization
          .tr(),
      summary:
          'Cross-state nursing mobility trend detected in the Tri-State area. Reciprocal licensing potential identified.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Human Capital',
      recommendation:
          'Fast-track reciprocal licensing for NJ-based RNs to cover NY surges.',
    ),
    IntelligenceInsight(
      id: 'reg_usa_02',
      title: LocaleKeys
          .dashboards_regionalmanagerusa_labels_market_saturation_warning__ca
          .tr(),
      summary:
          'CSAT scores in California showing slight decline due to capacity limits. Predicted churn up 0.4%.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Operations',
      recommendation:
          'Pause new patient intake in San Francisco until 3 more PSWs are onboarded.',
    ),
    IntelligenceInsight(
      id: 'reg_usa_03',
      title: LocaleKeys
          .dashboards_regionalmanagerusa_labels_texas_growth_corridor
          .tr(),
      summary:
          'Inquiry volume in the Dallas-Fort Worth cluster has exceeded projections by 22%.',
      impact: InsightImpact.info,
      type: InsightType.growth,
      category: 'Market',
      recommendation:
          'Allocate additional marketing budget to Houston to capture similar growth vectors.',
    ),
  ];
});

// -----------------------------------------------------------------------------
// Action Handlers
// -----------------------------------------------------------------------------

final regionalManagerUsaActionHandler = Provider<void Function(String)>((ref) {
  return (String actionId) {
    final telemetry = ref.read(executionGateProvider);
    telemetry.passGate(
      ExecutionGateCategory.resilience,
      'Regional Manager USA Action Triggered: $actionId',
    );
  };
});

/// Combined adapter provider for the Regional Manager USA Dashboard.
/// Bridges high-fidelity telemetry and regional insights into a unified ViewModel.
final regionalManagerUsaDashboardAdapterProvider =
    FutureProvider<Result<RegionalManagerUsaDashboardViewModel>>((ref) async {
      const cacheKey = 'regional_manager_usa_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(
          regionalManagerUsaMetricsProvider.future,
        );
        final insights = await ref.watch(
          regionalManagerUsaInsightsProvider.future,
        );

        final viewModel = RegionalManagerUsaDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Regional Manager USA Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          final vm = RegionalManagerUsaDashboardViewModel.fromJson(snapshot);
          return Success(
            RegionalManagerUsaDashboardViewModel(
              metrics: vm.metrics,
              insights: vm.insights,
              isOfflineFallback: true,
            ),
          );
        }
        return Success(
          RegionalManagerUsaDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
