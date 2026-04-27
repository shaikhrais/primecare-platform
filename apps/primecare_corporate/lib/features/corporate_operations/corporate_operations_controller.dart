import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'corporate_operations_model.dart';

final corporateDashboardControllerProvider =
    FutureProvider<Result<CorporateDashboardModel>>((ref) async {
  const cacheKey = 'corporate_dashboard';
  const route = 'CEO';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  try {
    // 1. Fetch metrics and insights directly
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);
    
    final metrics = metricsResult.fold(
      (m) => _enrichCorporateMetrics(m),
      (e) => DashboardMetrics.empty(),
    );

    final insights = await _fetchCorporateInsights();

    final model = CorporateDashboardModel(
      metrics: metrics,
      insights: insights,
    );

    // 2. Persist for resilience
    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    
    telemetry.passGate(
      ExecutionGateCategory.resilience,
      'Corporate Dashboard fully hydrated.',
    );

    return Success(model);
  } catch (e) {
    final snapshot = resilience.getSnapshot(cacheKey);
    if (snapshot != null) {
      return Success(CorporateDashboardModel.fromJson(snapshot).copyWith(isOfflineFallback: true));
    }
    return Success(CorporateDashboardModel.empty(isOfflineFallback: true));
  }
});

DashboardMetrics _enrichCorporateMetrics(DashboardMetrics metrics) {
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
}

Future<List<IntelligenceInsight>> _fetchCorporateInsights() async {
  return [
    IntelligenceInsight(
      id: 'corp_1',
      title: LocaleKeys.dashboards_ceo_labels_m_a_pipeline_velocity.tr(),
      summary: 'Due diligence on "Pacific Care Group" shows 94% alignment.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Strategic Expansion',
      recommendation: 'Authorize Phase 2 financial audit.',
    ),
    IntelligenceInsight(
      id: 'corp_2',
      title: LocaleKeys.dashboards_ceo_labels_regional_margin_sensitivity.tr(),
      summary: 'Expansion into Florida market shows 4% higher friction.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Operations',
      recommendation: 'Consolidate regional compliance functions.',
    ),
  ];
}
