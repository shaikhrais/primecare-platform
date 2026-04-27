import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'client_operations_model.dart';

final clientDashboardControllerProvider =
    FutureProvider<Result<ClientDashboardModel>>((ref) async {
  const route = 'Client';
  const cacheKey = 'client_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  try {
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);
    final metrics = metricsResult.fold((m) => _enhanceClientMetrics(m), (e) => DashboardMetrics.empty());

    final insights = _generateClientInsights();

    final model = ClientDashboardModel(
      metrics: metrics,
      insights: insights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  } catch (e) {
    final snapshot = resilience.getSnapshot(cacheKey);
    if (snapshot != null) {
      return Success(ClientDashboardModel.fromJson(snapshot).copyWith(isOfflineFallback: true));
    }
    return Success(ClientDashboardModel.empty(isOfflineFallback: true));
  }
});

DashboardMetrics _enhanceClientMetrics(DashboardMetrics original) {
  return DashboardMetrics(
    kpis: [
      KpiMetric(
        title: LocaleKeys.dashboards_client_labels_care_plan_progress.tr(),
        value: '85%',
        trend: '+5%',
        status: 'positive',
      ),
    ],
    charts: [],
    recentActivity: [],
  );
}

List<IntelligenceInsight> _generateClientInsights() {
  return [
    IntelligenceInsight(
      id: 'client_1',
      title: LocaleKeys.dashboards_client_labels_wellness_milestone.tr(),
      summary: 'You have maintained optimal vitals for 7 consecutive days.',
      type: InsightType.info,
      impact: InsightImpact.positive,
    ),
  ];
}
