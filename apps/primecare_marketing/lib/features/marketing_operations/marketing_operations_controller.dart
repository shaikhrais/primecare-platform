import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'marketing_operations_model.dart';

final marketingDashboardControllerProvider =
    FutureProvider<Result<MarketingDashboardModel>>((ref) async {
  const route = '/v2/marketing/head_of_marketing';
  const cacheKey = 'marketing_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  try {
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);
    final metrics = metricsResult.fold((m) => m, (e) => DashboardMetrics.empty());

    final insights = await _fetchMarketingInsights();

    final model = MarketingDashboardModel(
      metrics: metrics,
      insights: insights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  } catch (e) {
    final snapshot = resilience.getSnapshot(cacheKey);
    if (snapshot != null) {
      return Success(MarketingDashboardModel.fromJson(snapshot).copyWith(isOfflineFallback: true));
    }
    return Success(MarketingDashboardModel.empty(isOfflineFallback: true));
  }
});

Future<List<IntelligenceInsight>> _fetchMarketingInsights() async {
  return [
    IntelligenceInsight(
      id: 'mkt_1',
      title: LocaleKeys.marketing_dashboard_labels_campaign_roi_peak.tr(),
      summary: 'Q2 Clinical Growth campaign is delivering a 4.2x ROI.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Growth',
      recommendation: 'Reallocate 15% of LinkedIn budget.',
    ),
  ];
}
