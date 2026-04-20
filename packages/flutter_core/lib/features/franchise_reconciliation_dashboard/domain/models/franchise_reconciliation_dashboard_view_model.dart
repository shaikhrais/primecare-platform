import '../../../../flutter_core.dart';

class FranchiseReconciliationDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const FranchiseReconciliationDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory FranchiseReconciliationDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return FranchiseReconciliationDashboardViewModel(
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
        const StitchBlueprint(screenId: 'franchise_reconciliation_dashboard'),
      ],
    );
  }

  factory FranchiseReconciliationDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return FranchiseReconciliationDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory FranchiseReconciliationDashboardViewModel.assemble({
    required bool isOffline,
  }) {
    final metrics = DataLogisticsHub.getDashboardMetrics(
      'franchise_reconciliation',
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

    return FranchiseReconciliationDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: universalKpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const AuraDashboardHudBlueprint(),
        const StitchBlueprint(screenId: 'franchise_reconciliation_dashboard'),
      ],
    );
  }

  factory FranchiseReconciliationDashboardViewModel.empty() =>
      FranchiseReconciliationDashboardViewModel.assemble(isOffline: true);
}
