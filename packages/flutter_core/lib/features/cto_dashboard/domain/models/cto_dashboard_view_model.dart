import 'package:primecare_core/flutter_core.dart';

class CtoDashboardViewModel extends PrimeCareDashboardViewModel {
  const CtoDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
    super.forecasting,
  });

  factory CtoDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return CtoDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
      forecasting: base.forecasting,
    );
  }

  factory CtoDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    AIAnalyticsForecastingData? forecasting,
    bool isOffline = false,
  }) {
    return CtoDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      forecasting: forecasting,
      blueprints: [
        StatGridBlueprint(
          dataPayload: metrics.kpis
              .map(
                (kpi) => UniversalKpi(
                  title: kpi.title,
                  value: kpi.value,
                  trend: 0.0,
                  status: UniversalKpi.mapStatus(kpi.status),
                ),
              )
              .toList(),
        ),
        if (forecasting != null)
          AIForecastingBlueprint(dataPayload: forecasting),
        ActivityFeedBlueprint(
          dataPayload: metrics.recentActivity.map((e) => e.toJson()).toList(),
        ),
        const RiskMonitorBlueprint(
          dataPayload: {
            'status': 'WARNING',
            'summary':
                'API Rate limit approaching 90% threshold for tenant integration endpoints.',
          },
        ),
        const StitchBlueprint(
          screenId: '9a8b7c6d5e244705a405113ae8623ec3', // CTO Dashboard
        ),
      ],
    );
  }

  static CtoDashboardViewModel assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('cto');
    return CtoDashboardViewModel.fromDashboardMetrics(
      metrics,
      isOffline: isOffline,
    );
  }
}
