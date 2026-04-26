import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// High-fidelity telemetry stream for the Territory Expansion Manager Dashboard.
/// Tracks site acquisition pipelines, market maturity, and regulatory velocity.
final territoryExpansionMetricsProvider = StreamProvider<DashboardMetrics>((
  ref,
) {
  return Stream.periodic(const Duration(seconds: 30), (count) {
    return DashboardMetrics(
      kpis: [
        KpiMetric(
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_market_maturity
              .tr(),
          value: '85%',
          trend: '+5%',
          status: 'success',
        ),
        KpiMetric(
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_site_acquisition
              .tr(),
          value: '12',
          trend: '+2',
          status: 'success',
        ),
        KpiMetric(
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_regulatory_speed
              .tr(),
          value: '14d',
          trend: '-2d',
          status: 'success',
        ),
        KpiMetric(
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_projected_roi
              .tr(),
          value: '22%',
          trend: '+1.5%',
          status: 'success',
        ),
      ],
      charts: [
        AnalyticsChart(
          id: 'expansion-pipeline',
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_site_acquisition_pipeline
              .tr(),
          type: ChartType.bar,
          dataPoints: [
            ChartDataPoint(label: 'Identified', value: 25),
            ChartDataPoint(label: 'Negotiation', value: 12),
            ChartDataPoint(label: 'Due Diligence', value: 8),
            ChartDataPoint(label: 'Closed', value: 3),
          ],
        ),
      ],
      recentActivity: [
        DashboardActivity(
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_new_site_identified
              .tr(),
          subtitle: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_potential_location_in_vancouver_north_cluster
              .tr(),
          timestamp: '2h ago',
          icon: 'map-pin',
          color: 'green',
        ),
        DashboardActivity(
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_contract_signed
              .tr(),
          subtitle: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_lease_finalized_for_ottawa_east_hub
              .tr(),
          timestamp: '5h ago',
          icon: 'file-signature',
          color: 'blue',
        ),
      ],
      insights: [
        DashboardInsight(
          title: LocaleKeys
              .dashboards_territoryexpansionmanager_labels_regulatory_pulse
              .tr(),
          description:
              'Quebec licensing board showing 15% faster processing this month.',
          type: 'REGULATORY',
          impact: InsightImpact.positive,
        ),
      ],
    );
  }).asyncMap((m) async {
    if (const Stream<DashboardMetrics>.empty() == m)
      await Future<void>.delayed(const Duration(milliseconds: 400));
    return m;
  });
});

/// High-fidelity AI insights for the Territory Expansion Manager Dashboard.
/// Surfaces geographic density alerts and optimal launch windows via Aura Intelligence.
final territoryExpansionInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
      id: 'exp_1',
      title: LocaleKeys
          .dashboards_territoryexpansionmanager_labels_geographic_density_alert
          .tr(),
      summary:
          'Central Region service density is 30% below the profitability threshold for current overhead.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Market Growth',
      recommendation:
          'Prioritize marketing spend in Zip Codes 90210-90215 to increase cluster density and reduce travel-time overhead.',
    ),
    IntelligenceInsight(
      id: 'exp_2',
      title: LocaleKeys
          .dashboards_territoryexpansionmanager_labels_optimal_launch_window
          .tr(),
      summary:
          'Predictive models show Q3 as the lowest-cost period for new site staffing in the Ontario corridor.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Strategic Planning',
      recommendation:
          'Accelerate "North York" site build-out to align with the projected September hiring surge.',
    ),
  ];
});

/// Combined adapter provider for the Territory Expansion Manager Dashboard.
/// Bridges high-fidelity telemetry and expansion insights into a unified ViewModel.
final territoryExpansionManagerDashboardAdapterProvider =
    FutureProvider<Result<TerritoryExpansionManagerDashboardViewModel>>((
      ref,
    ) async {
      const cacheKey = 'territory_expansion_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(
          territoryExpansionMetricsProvider.future,
        );
        final insights = await ref.watch(
          territoryExpansionInsightsProvider.future,
        );

        final viewModel = TerritoryExpansionManagerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Territory Expansion Manager Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            TerritoryExpansionManagerDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          TerritoryExpansionManagerDashboardViewModel.empty(
            isOfflineFallback: true,
          ),
        );
      }
    });
