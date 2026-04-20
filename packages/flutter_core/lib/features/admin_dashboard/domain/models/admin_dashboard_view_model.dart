import '../../../../flutter_core.dart';

class AdminDashboardViewModel extends PrimeCareDashboardViewModel {
  const AdminDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory AdminDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return AdminDashboardViewModel(
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
      blueprints: [const StitchBlueprint(screenId: 'admin_dashboard')],
    );
  }

  factory AdminDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return AdminDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory AdminDashboardViewModel.assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('admin');

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

    return AdminDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: universalKpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const AuraDashboardHudBlueprint(),
        const StitchBlueprint(screenId: 'admin_dashboard'),
      ],
    );
  }

  factory AdminDashboardViewModel.empty() =>
      AdminDashboardViewModel.assemble(isOffline: true);
}
