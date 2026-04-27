import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'franchise_operations_model.dart';

final franchiseDashboardControllerProvider =
    FutureProvider<Result<FranchiseDashboardModel>>((ref) async {
  const cacheKey = 'franchise_dashboard';
  const route = '/v2/franchise/franchise_owner';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  try {
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);
    final metrics = metricsResult.fold((m) => m, (e) => DashboardMetrics.empty());

    final insights = await _fetchFranchiseInsights();

    final model = FranchiseDashboardModel(
      metrics: metrics,
      insights: insights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  } catch (e) {
    final snapshot = resilience.getSnapshot(cacheKey);
    if (snapshot != null) {
      return Success(FranchiseDashboardModel.fromJson(snapshot).copyWith(isOfflineFallback: true));
    }
    return Success(FranchiseDashboardModel.empty(isOfflineFallback: true));
  }
});

Future<List<IntelligenceInsight>> _fetchFranchiseInsights() async {
  return [
    IntelligenceInsight(
      id: 'fra_1',
      title: LocaleKeys.dashboards_franchiseowner_labels_territory_expansion_opportunity.tr(),
      summary: 'Adjacent postal code (L4B) shows 300% increase in searches.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Market',
      recommendation: 'Inquire with Corporate about sub-territory licensing.',
    ),
  ];
}
