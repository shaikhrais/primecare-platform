import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';

class ScrumMasterDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  const ScrumMasterDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
  });

  factory ScrumMasterDashboardViewModel.assemble({required bool isOffline}) {
    return ScrumMasterDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: []),
        const ActivityFeedBlueprint(dataPayload: []),
      ],
    );
  }

  factory ScrumMasterDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return ScrumMasterDashboardViewModel(
      isOfflineFallback: false,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: _generateBlueprints(metrics),
    );
  }

  static List<UIComponentBlueprint> _generateBlueprints(DashboardMetrics metrics) {
    return [
      StatGridBlueprint(
        dataPayload: metrics.kpis.map((k) => UniversalKpi(
          title: k.title,
          value: k.value,
          trend: double.tryParse(k.trend ?? '0') ?? 0.0,
          status: UniversalKpi.mapStatus(k.status),
        )).toList(),
      ),
      if (metrics.recentActivity.isNotEmpty)
        ActivityFeedBlueprint(dataPayload: metrics.recentActivity),
    ];
  }
}
