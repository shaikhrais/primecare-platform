import '../../../../flutter_core.dart';

class TerritorySalesManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TerritorySalesManagerDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory TerritorySalesManagerDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return TerritorySalesManagerDashboardViewModel(
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
      blueprints: [
        const StitchBlueprint(screenId: 'territory_sales_manager_dashboard'),
      ],
    );
  }

  factory TerritorySalesManagerDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return TerritorySalesManagerDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory TerritorySalesManagerDashboardViewModel.assemble({
    required bool isOffline,
  }) {
    final metrics = DataLogisticsHub.getDashboardMetrics(
      'territory_sales_manager',
    );

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

    return TerritorySalesManagerDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: universalKpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const AuraDashboardHudBlueprint(),
        const StitchBlueprint(screenId: 'territory_sales_manager_dashboard'),
      ],
    );
  }

  factory TerritorySalesManagerDashboardViewModel.empty() =>
      TerritorySalesManagerDashboardViewModel.assemble(isOffline: true);
}
