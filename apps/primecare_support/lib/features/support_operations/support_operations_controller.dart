import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'support_operations_model.dart';

final supportDashboardControllerProvider =
    FutureProvider<Result<SupportDashboardModel>>((ref) async {
  const cacheKey = 'support_dashboard';
  const route = 'SUPPORT';
  final resilience = ref.read(resilienceServiceProvider);

  try {
    final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);
    final metrics = metricsResult.fold((m) => m, (e) => DashboardMetrics.empty());

    final insights = await _fetchSupportInsights();

    final model = SupportDashboardModel(
      metrics: metrics,
      insights: insights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  } catch (e) {
    final snapshot = resilience.getSnapshot(cacheKey);
    if (snapshot != null) {
      return Success(SupportDashboardModel.fromJson(snapshot).copyWith(isOfflineFallback: true));
    }
    return Success(SupportDashboardModel.empty(isOfflineFallback: true));
  }
});

Future<List<IntelligenceInsight>> _fetchSupportInsights() async {
  return [
    IntelligenceInsight(
      id: 'supp_1',
      title: LocaleKeys.support_dashboard_labels_common_pain_point.tr(),
      summary: '60% of tickets relate to "Credential Expiry".',
      impact: InsightImpact.info,
      type: InsightType.alert,
      category: 'UX Optimization',
      recommendation: 'Update email templates.',
    ),
  ];
}
