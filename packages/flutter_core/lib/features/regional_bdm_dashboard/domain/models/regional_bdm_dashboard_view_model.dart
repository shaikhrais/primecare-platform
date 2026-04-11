import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class RegionalBdmDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;
  
  final Map<String, dynamic> metrics;
  final List<dynamic> activities;
  final List<dynamic> alerts;

  RegionalBdmDashboardViewModel({
    required this.metrics,
    this.activities = const [],
    this.alerts = const [],
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory RegionalBdmDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return RegionalBdmDashboardViewModel(
      metrics: metrics.stats,
      activities: metrics.recentActivity,
      alerts: metrics.alerts,
      blueprints: [], // Placeholder for now, can be populated with converted metrics
    );
  }
}

// Subtypes to satisfy specific screen expectations if needed
class RegionalBdmSalesDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmSalesDashboardViewModel({required super.metrics, super.activities, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmSalesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmSalesDashboardViewModel(
        metrics: metrics.stats,
        activities: metrics.recentActivity,
        alerts: metrics.alerts,
        blueprints: [],
      );
}

class RegionalBdmDealTrackerDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmDealTrackerDashboardViewModel({required super.metrics, super.activities, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmDealTrackerDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmDealTrackerDashboardViewModel(
        metrics: metrics.stats,
        activities: metrics.recentActivity,
        alerts: metrics.alerts,
        blueprints: [],
      );
}

class RegionalBdmCompetitorNotesDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmCompetitorNotesDashboardViewModel({required super.metrics, super.activities, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmCompetitorNotesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmCompetitorNotesDashboardViewModel(
        metrics: metrics.stats,
        activities: metrics.recentActivity,
        alerts: metrics.alerts,
        blueprints: [],
      );
}

class RegionalBdmRecruitmentDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmRecruitmentDashboardViewModel({required super.metrics, super.activities, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmRecruitmentDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmRecruitmentDashboardViewModel(
        metrics: metrics.stats,
        activities: metrics.recentActivity,
        alerts: metrics.alerts,
        blueprints: [],
      );
}
