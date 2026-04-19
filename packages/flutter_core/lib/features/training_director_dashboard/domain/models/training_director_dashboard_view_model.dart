import 'package:primecare_core/flutter_core.dart';

class TrainingDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const TrainingDirectorDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
    super.forecasting,
  });

  factory TrainingDirectorDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return TrainingDirectorDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
      forecasting: base.forecasting,
    );
  }

  factory TrainingDirectorDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    AIAnalyticsForecastingData? forecasting,
    bool isOffline = false,
  }) {
    return TrainingDirectorDashboardViewModel(
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
        const StitchBlueprint(
          screenId: '1b2c3d4e5f244705a405113ae8623ec5', // Training Dashboard
        ),
      ],
    );
  }

  static TrainingDirectorDashboardViewModel assemble({
    required bool isOffline,
  }) {
    final metrics = DataLogisticsHub.getDashboardMetrics('training');
    return TrainingDirectorDashboardViewModel.fromDashboardMetrics(
      metrics,
      isOffline: isOffline,
    );
  }
}
