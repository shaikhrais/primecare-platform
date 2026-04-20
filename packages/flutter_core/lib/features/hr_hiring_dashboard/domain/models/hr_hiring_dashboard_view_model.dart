import '../../../../flutter_core.dart';

class HRHiringDashboardViewModel extends PrimeCareDashboardViewModel {
  const HRHiringDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory HRHiringDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return HRHiringDashboardViewModel(
      isOfflineFallback: false,
      kpis: metrics.kpis
          .map(
            (k) => UniversalKpi(
              title: k.title,
              value: k.value,
              trend:
                  double.tryParse(k.trend?.replaceAll('%', '') ?? '0') ?? 0.0,
              status: UniversalKpi.mapStatus(k.status),
            ),
          )
          .toList(),
      recentActivity: metrics.recentActivity,
      blueprints: [const StitchBlueprint(screenId: 'hr_hiring_dashboard')],
    );
  }

  factory HRHiringDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return HRHiringDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory HRHiringDashboardViewModel.assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('hr_hiring');

    final universalKpis = metrics.kpis
        .map(
          (k) => UniversalKpi(
            title: k.title,
            value: k.value,
            trend: double.tryParse(k.trend?.replaceAll('%', '') ?? '0') ?? 0.0,
            status: UniversalKpi.mapStatus(k.status),
          ),
        )
        .toList();

    return HRHiringDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: universalKpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const AuraDashboardHudBlueprint(),
        const StitchBlueprint(screenId: 'hr_hiring_dashboard'),
      ],
    );
  }

  factory HRHiringDashboardViewModel.empty() =>
      HRHiringDashboardViewModel.assemble(isOffline: true);
}
