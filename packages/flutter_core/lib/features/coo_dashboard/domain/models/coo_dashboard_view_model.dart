import 'package:primecare_core/flutter_core.dart';

class CooDashboardViewModel extends PrimeCareDashboardViewModel {
  const CooDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory CooDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return CooDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory CooDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    bool isOffline = false,
  }) {
    return CooDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
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
        const StitchBlueprint(
          screenId: '5e1d8a1b9c244705a405113ae8623ec1', // COO Dashboard
        ),
      ],
    );
  }

  static CooDashboardViewModel assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('coo');
    return CooDashboardViewModel.fromDashboardMetrics(
      metrics,
      isOffline: isOffline,
    );
  }
}
