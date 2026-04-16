import 'package:primecare_core/flutter_core.dart';

class CtoDashboardViewModel extends PrimeCareDashboardViewModel {
  const CtoDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory CtoDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics,
      {bool isOffline = false}) {
    return CtoDashboardViewModel(
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
          screenId: '9a8b7c6d5e244705a405113ae8623ec3', // CTO Dashboard
        ),
      ],
    );
  }

  static CtoDashboardViewModel assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('cto');
    return CtoDashboardViewModel.fromDashboardMetrics(metrics,
        isOffline: isOffline);
  }
}
