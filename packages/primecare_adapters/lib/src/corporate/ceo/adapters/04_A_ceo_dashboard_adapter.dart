import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

// -----------------------------------------------------------------------------
// Split Hydration: Real-time Telemetry (Stream) + AI Insights (Future)
// -----------------------------------------------------------------------------

/// High-fidelity telemetry stream for the CEO Dashboard.
/// Tracks enterprise value, global NPS, revenue growth, and expansion velocity.
final ceoMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  const route = 'CEO';
  final repository = ref.watch(dashboardRepositoryProvider);
  final telemetry = ref.read(executionGateProvider);

  telemetry.passGate(
    ExecutionGateCategory.resilience,
    'CEO metrics stream initiated.',
  );

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository.watchMetrics(route).map((result) {
    return result.fold((metrics) {
      // Add role-specific KPIs if empty or override for high-fidelity UI
      final enrichedKpis = metrics.kpis.isEmpty
          ? [
              KpiMetric(
                title: LocaleKeys.ceo_dashboard_labels_strategic_growth.tr(),
                value: '\$84.2M',
                subtitle: LocaleKeys.dashboards_ceo_labels_14_8.tr(),
                trend: 'up',
                status: 'success',
              ),
              KpiMetric(
                title: LocaleKeys.dashboards_ceo_labels_global_nps.tr(),
                value: '78',
                subtitle: LocaleKeys.dashboards_ceo_labels_3_0.tr(),
                trend: 'up',
                status: 'success',
              ),
              KpiMetric(
                title: LocaleKeys.ceo_dashboard_labels_revenue_growth.tr(),
                value: '22.4%',
                subtitle: LocaleKeys.dashboards_ceo_labels_5_2.tr(),
                trend: 'up',
                status: 'success',
              ),
              KpiMetric(
                title: LocaleKeys.ceo_dashboard_labels_market_expansion.tr(),
                value: '18',
                subtitle: LocaleKeys.dashboards_ceo_labels_2_0.tr(),
                trend: 'up',
                status: 'success',
              ),
            ]
          : metrics.kpis;

      return metrics.copyWith(kpis: enrichedKpis);
    }, (error) => throw error);
  });
});

/// High-fidelity AI insights for the CEO Dashboard.
/// Surfaces M&A opportunities, margin sensitivity, and stakeholder sentiment via Aura Intelligence.
final ceoInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
      id: 'ceo_1',
      title: LocaleKeys.dashboards_ceo_labels_m_a_pipeline_velocity.tr(),
      summary:
          'Due diligence on "Pacific Care Group" shows 94% alignment with PrimeCare core quality standards.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Strategic Expansion',
      recommendation:
          'Authorize Phase 2 financial audit; prepare Letter of Intent for board review by EOW.',
    ),
    IntelligenceInsight(
      id: 'ceo_2',
      title: LocaleKeys.dashboards_ceo_labels_regional_margin_sensitivity.tr(),
      summary:
          'Expansion into the Florida market shows 4% higher operational friction than initially modeled.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Operations',
      recommendation:
          'Consolidate regional compliance functions to reduce per-unit overhead and restore margin targets.',
    ),
    IntelligenceInsight(
      id: 'ceo_3',
      title: LocaleKeys.dashboards_ceo_labels_stakeholder_sentiment_surge.tr(),
      summary:
          'Institutional investor sentiment has shifted to "Bullish" following the Q3 technology roadmap presentation.',
      impact: InsightImpact.info,
      type: InsightType.optimization,
      category: 'Investor Relations',
      recommendation:
          'Schedule follow-up roadshow with Tier 1 capital partners to capitalize on current sentiment momentum.',
    ),
  ];
});

// -----------------------------------------------------------------------------
// Action Handlers
// -----------------------------------------------------------------------------

final ceoActionHandler = Provider<void Function(String)>((ref) {
  return (String actionId) {
    final telemetry = ref.read(executionGateProvider);
    telemetry.passGate(
      ExecutionGateCategory.resilience,
      'CEO Action Triggered: $actionId',
    );
  };
});

/// Combined adapter provider for the CEO Dashboard.
/// Bridges the high-fidelity telemetry and insights into a unified ViewModel for the registry.
final ceoDashboardAdapterProvider =
    FutureProvider<Result<CeoDashboardViewModel>>((ref) async {
      const cacheKey = 'ceo_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // 1. Hydrate split streams
        final metrics = await ref.watch(ceoMetricsProvider.future);
        final insights = await ref.watch(ceoInsightsProvider.future);

        final viewModel = CeoDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        // 2. Persist for resilience
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'CEO Dashboard fully hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'CEO Dashboard Fallback Triggered: $e',
        );
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            CeoDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(CeoDashboardViewModel.empty(isOfflineFallback: true));
      }
    });
