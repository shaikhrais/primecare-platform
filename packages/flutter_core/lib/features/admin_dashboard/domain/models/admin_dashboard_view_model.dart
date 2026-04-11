import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';

class AdminDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  const AdminDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
  });

  factory AdminDashboardViewModel.assemble({required bool isOffline}) {
    return AdminDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: []),
        const ActivityFeedBlueprint(dataPayload: []),
      ],
    );
  }

  factory AdminDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return AdminDashboardViewModel(
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
