import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../../../dashboard_service.dart';

class ClinicDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;

  const ClinicDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
    this.kpis = const [],
    this.recentActivity = const [],
  });

  factory ClinicDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return ClinicDashboardViewModel(
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
          trend: k.trend,
          status: k.status,
        )).toList(),
      ),
      if (metrics.recentActivity.isNotEmpty)
        ActivityFeedBlueprint(dataPayload: metrics.recentActivity),
    ];
  }

  factory ClinicDashboardViewModel.assemble({required bool isOffline}) {
    return ClinicDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
