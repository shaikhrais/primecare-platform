import '../../../../flutter_core.dart';

class QaDashboardViewModel extends PrimeCareDashboardViewModel {
  const QaDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory QaDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return QaDashboardViewModel(
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
      blueprints: [const StitchBlueprint(screenId: 'qa_dashboard')],
    );
  }

  factory QaDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return QaDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory QaDashboardViewModel.assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('qa');

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

    return QaDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: universalKpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const AuraDashboardHudBlueprint(),
        const StitchBlueprint(screenId: 'qa_dashboard'),
      ],
    );
  }

  factory QaDashboardViewModel.empty() =>
      QaDashboardViewModel.assemble(isOffline: true);
}
