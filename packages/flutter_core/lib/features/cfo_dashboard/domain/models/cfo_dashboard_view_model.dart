import 'package:primecare_core/flutter_core.dart';

class CfoDashboardViewModel extends PrimeCareDashboardViewModel {
  const CfoDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory CfoDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return CfoDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory CfoDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    bool isOffline = false,
  }) {
    return CfoDashboardViewModel(
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
          screenId: '2f3e9b1c8d244705a405113ae8623ec2', // CFO Dashboard
        ),
      ],
    );
  }

  static CfoDashboardViewModel assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('cfo');
    return CfoDashboardViewModel.fromDashboardMetrics(
      metrics,
      isOffline: isOffline,
    );
  }
}
