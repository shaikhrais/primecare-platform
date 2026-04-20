import '../../../../flutter_core.dart';

class RegionalManagerOntarioDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const RegionalManagerOntarioDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory RegionalManagerOntarioDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return RegionalManagerOntarioDashboardViewModel(
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
        const StitchBlueprint(screenId: 'regional_manager_ontario_dashboard'),
      ],
    );
  }

  factory RegionalManagerOntarioDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return RegionalManagerOntarioDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory RegionalManagerOntarioDashboardViewModel.assemble({
    required bool isOffline,
  }) {
    final metrics = DataLogisticsHub.getDashboardMetrics(
      'regional_manager_ontario',
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

    return RegionalManagerOntarioDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: universalKpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const AuraDashboardHudBlueprint(),
        const StitchBlueprint(screenId: 'regional_manager_ontario_dashboard'),
      ],
    );
  }

  factory RegionalManagerOntarioDashboardViewModel.empty() =>
      RegionalManagerOntarioDashboardViewModel.assemble(isOffline: true);
}
