import '../../../../flutter_core.dart';

class ComplianceManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const ComplianceManagerDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory ComplianceManagerDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return ComplianceManagerDashboardViewModel(
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
        const StitchBlueprint(screenId: 'compliance_manager_dashboard'),
      ],
    );
  }

  factory ComplianceManagerDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return ComplianceManagerDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory ComplianceManagerDashboardViewModel.assemble({
    required bool isOffline,
  }) {
    final metrics = DataLogisticsHub.getDashboardMetrics('compliance_manager');

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

    return ComplianceManagerDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: universalKpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const AuraDashboardHudBlueprint(),
        const StitchBlueprint(screenId: 'compliance_manager_dashboard'),
      ],
    );
  }

  factory ComplianceManagerDashboardViewModel.empty() =>
      ComplianceManagerDashboardViewModel.assemble(isOffline: true);
}
