import 'package:primecare_core/flutter_core.dart';

class TrainingDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const TrainingDirectorDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory TrainingDirectorDashboardViewModel.fromDashboardMetrics(
      DashboardMetrics metrics,
      {bool isOffline = false}) {
    return TrainingDirectorDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(
          dataPayload: metrics.kpis
              .map((kpi) => UniversalKpi(
                    title: kpi.title,
                    value: kpi.value,
                    trend: 0.0,
                    status: UniversalKpi.mapStatus(kpi.status),
                  ))
              .toList(),
        ),
        const StitchBlueprint(
          screenId: '1b2c3d4e5f244705a405113ae8623ec5', // Training Dashboard
        ),
      ],
    );
  }

  static TrainingDirectorDashboardViewModel assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('training');
    return TrainingDirectorDashboardViewModel.fromDashboardMetrics(metrics,
        isOffline: isOffline);
  }
}
