import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../../../dashboard_service.dart';

class HeadOfMarketingDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;
  
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;

  const HeadOfMarketingDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
    this.kpis = const [],
    this.recentActivity = const [],
  });

  static List<UIComponentBlueprint> generateBlueprints(DashboardMetrics metrics) {
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
}
