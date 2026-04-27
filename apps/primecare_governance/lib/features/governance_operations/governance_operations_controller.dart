import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'governance_operations_model.dart';

final governanceDashboardControllerProvider =
    FutureProvider<Result<GovernanceDashboardModel>>((ref) async {
  const cacheKey = 'governance_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  try {
    // In a real app, this might fetch from a specialized governance endpoint
    final metrics = DashboardMetrics(
      kpis: [
        KpiMetric(
          title: LocaleKeys.dashboards_corporategovernance_labels_compliance_score.tr(),
          value: '98.4%',
          status: 'positive',
        ),
      ],
      recentActivity: [],
      charts: [],
    );

    final insights = [
      IntelligenceInsight(
        id: 'gov_1',
        title: LocaleKeys.dashboards_corporategovernance_labels_blueprint_mismatch_detected.tr(),
        summary: '3 clinical screens show minor structural drift.',
        impact: InsightImpact.warning,
        category: 'Integrity',
        recommendation: 'Run remediation script.',
      ),
    ];

    final model = GovernanceDashboardModel(
      metrics: metrics,
      insights: insights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  } catch (e) {
    final snapshot = resilience.getSnapshot(cacheKey);
    if (snapshot != null) {
      return Success(GovernanceDashboardModel.fromJson(snapshot).copyWith(isOfflineFallback: true));
    }
    return Success(GovernanceDashboardModel.empty(isOfflineFallback: true));
  }
});
