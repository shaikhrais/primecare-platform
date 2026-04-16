import 'package:primecare_core/flutter_core.dart';

class CeoDashboardViewModel extends PrimeCareDashboardViewModel {
  const CeoDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory CeoDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return CeoDashboardViewModel(
      isOfflineFallback: false,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        const StitchBlueprint(screenId: '34b19469e4724705a405113ae8623ec0'),
      ],
    );
  }

  factory CeoDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return CeoDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory CeoDashboardViewModel.assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('ceo');
    
    // Convert KpiMetric to UniversalKpi for the StatGridBlueprint with high-fidelity mapping
    final universalKpis = metrics.kpis.map((k) => UniversalKpi(
      title: k.title,
      value: k.value,
      trend: double.tryParse(k.trend?.replaceAll('%', '') ?? '0') ?? 0.0, 
      status: UniversalKpi.mapStatus(k.status),
    )).toList();

    return CeoDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(dataPayload: universalKpis),
        const StitchBlueprint(screenId: '34b19469e4724705a405113ae8623ec0'),
      ],
    );
  }
}

