import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'clinic_operations_model.dart';
import 'package:easy_localization/easy_localization.dart';

final clinicDashboardControllerProvider =
    FutureProvider<Result<ClinicDashboardModel>>((ref) async {
  const route = 'ClinicManager';
  const cacheKey = 'clinic_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  try {
    final result = await ref.watch(dashboardMetricsProvider(route).future);
    return result.fold(
      (metrics) {
        final model = ClinicDashboardModel(
          metrics: _enhanceClinicMetrics(metrics),
          insights: _generateClinicInsights(),
        );
        unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
        return Success(model);
      },
      (error) => _handleFallback(resilience, cacheKey, telemetry, error),
    );
  } catch (e) {
    return _handleFallback(resilience, cacheKey, telemetry, e);
  }
});

DashboardMetrics _enhanceClinicMetrics(DashboardMetrics original) {
  return DashboardMetrics(
    kpis: [
      KpiMetric(
        title: LocaleKeys.dashboards_clinic_labels_safety_score.tr(),
        value: '98.2',
        trend: '+1.5%',
        status: 'positive',
      ),
      KpiMetric(
        title: LocaleKeys.dashboards_clinic_labels_occupancy.tr(),
        value: '92%',
        trend: '+4%',
        status: 'positive',
      ),
      KpiMetric(
        title: LocaleKeys.dashboards_clinic_labels_compliance_rate.tr(),
        value: '99.8%',
        trend: 'Stable',
        status: 'positive',
      ),
      KpiMetric(
        title: LocaleKeys.dashboards_clinic_labels_incident_rate.tr(),
        value: '0.4%',
        trend: '-0.2%',
        status: 'positive',
      ),
    ],
    recentActivity: [
      DashboardActivity(
        title: LocaleKeys.dashboards_clinic_labels_safety_audit_complete.tr(),
        subtitle: LocaleKeys
            .dashboards_clinic_labels_floor_3_clinical_audit_passed_with_100__compliance
            .tr(),
        timestamp: '2h ago',
        icon: 'shield_check',
        color: 'green',
      ),
      DashboardActivity(
        title: LocaleKeys.dashboards_clinic_labels_incident_resolved.tr(),
        subtitle: LocaleKeys
            .dashboards_clinic_labels_medication_discrepancy_in_room_402_investigated_and_closed
            .tr(),
        timestamp: '5h ago',
        icon: 'check_circle',
        color: 'blue',
      ),
    ],
    charts: [
      AnalyticsChart(
        id: 'clinical_safety',
        title: LocaleKeys.dashboards_clinic_labels_safety_velocity__4w.tr(),
        type: ChartType.bar,
        labels: ['W1', 'W2', 'W3', 'W4'],
        datasets: [
          AnalyticsChartDataset(
            label: 'Actual Safety',
            data: [94, 91, 96, 98.2],
          ),
          AnalyticsChartDataset(label: 'Benchmark', data: [90, 90, 90, 90]),
        ],
      ),
    ],
  );
}

List<IntelligenceInsight> _generateClinicInsights() {
  return [
    IntelligenceInsight(
      id: 'clinic_insight_1',
      title: LocaleKeys.dashboards_clinic_labels_medication_optimization.tr(),
      summary:
          'Automation of Floor 2 medication cart could reduce distribution time by 15%.',
      type: InsightType.optimization,
      impact: InsightImpact.positive,
      recommendation: 'Evaluate automated dispensing systems for Q3 rollout.',
      category: 'Operations',
    ),
    IntelligenceInsight(
      id: 'clinic_insight_2',
      title: LocaleKeys.dashboards_clinic_labels_compliance_alert.tr(),
      summary:
          'Upcoming RPN certification renewals required for 4 staff members in 14 days.',
      type: InsightType.compliance,
      impact: InsightImpact.warning,
      recommendation: 'Trigger automated renewal reminders via the HR portal.',
      category: 'Regulatory',
    ),
  ];
}

Result<ClinicDashboardModel> _handleFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
  dynamic error,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    return Success(ClinicDashboardModel.fromJson(snapshot));
  }
  return Success(ClinicDashboardModel.empty(isOfflineFallback: true));
}
