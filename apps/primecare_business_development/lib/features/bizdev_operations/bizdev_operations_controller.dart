import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'bizdev_operations_model.dart';

final bizDevDashboardControllerProvider =
    FutureProvider<Result<BizDevDashboardModel>>((ref) async {
  const route = 'FRANCHISE_SALES_MANAGER';
  const cacheKey = 'bizdev_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  try {
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);
    final metrics = metricsResult.fold((m) => m, (e) => DashboardMetrics.empty());

    final insights = _getSmartFranchiseSalesMocks();

    final model = BizDevDashboardModel(
      metrics: metrics,
      insights: insights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  } catch (e) {
    final snapshot = resilience.getSnapshot(cacheKey);
    if (snapshot != null) {
      return Success(BizDevDashboardModel.fromJson(snapshot).copyWith(isOfflineFallback: true));
    }
    return Success(BizDevDashboardModel.empty(isOfflineFallback: true));
  }
});

List<IntelligenceInsight> _getSmartFranchiseSalesMocks() {
  return [
    IntelligenceInsight(
      id: 'fsm_1',
      title: LocaleKeys.dashboards_franchisesalesmanager_labels_territory_saturation_alert.tr(),
      summary: 'Toronto West territory is reaching 95% franchise density.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Market',
      recommendation: 'Pause new applications for Toronto West.',
    ),
  ];
}
