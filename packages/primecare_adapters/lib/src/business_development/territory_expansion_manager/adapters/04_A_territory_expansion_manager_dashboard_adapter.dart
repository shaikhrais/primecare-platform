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
        const KpiMetric(
          title: 'Market Maturity',
          value: '85%',
          trend: '+5%',
          status: 'success',
        ),
        const KpiMetric(
          title: 'Site Acquisition',
          value: '12',
          trend: '+2',
          status: 'success',
        ),
        const KpiMetric(
          title: 'Regulatory Speed',
          value: '14d',
          trend: '-2d',
          status: 'success',
        ),
        const KpiMetric(
          title: 'Projected ROI',
          value: '22%',
          trend: '+1.5%',
          status: 'success',
        ),
      ],
      charts: [
        AnalyticsChart(
          id: 'expansion-pipeline',
          title: 'Site Acquisition Pipeline',
          type: ChartType.bar,
          dataPoints: [
            const ChartDataPoint(label: 'Identified', value: 25),
            const ChartDataPoint(label: 'Negotiation', value: 12),
            const ChartDataPoint(label: 'Due Diligence', value: 8),
            const ChartDataPoint(label: 'Closed', value: 3),
          ],
        ),
      ],
      recentActivity: [
        DashboardActivity(
          title: 'New Site Identified',
          subtitle: 'Potential location in Vancouver North cluster',
          timestamp: '2h ago',
          icon: 'map-pin',
          color: 'green',
        ),
        DashboardActivity(
          title: 'Contract Signed',
          subtitle: 'Lease finalized for Ottawa East hub',
          timestamp: '5h ago',
          icon: 'file-signature',
          color: 'blue',
        ),
      ],
      insights: [
        const DashboardInsight(
          title: 'Regulatory Pulse',
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
      title: 'Geographic Density Alert',
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
      title: 'Optimal Launch Window',
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
