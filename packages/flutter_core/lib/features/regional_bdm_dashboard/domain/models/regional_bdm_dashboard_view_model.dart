import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class RegionalBdmDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;
  
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<dynamic> alerts;

  RegionalBdmDashboardViewModel({
    required this.kpis,
    this.recentActivity = const [],
    this.alerts = const [],
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory RegionalBdmDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return RegionalBdmDashboardViewModel(
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: [], // Placeholder for now
    );
  }
}

// Subtypes to satisfy specific screen expectations if needed
class RegionalBdmSalesDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmSalesDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmSalesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmSalesDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmDealTrackerDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmDealTrackerDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmDealTrackerDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmDealTrackerDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmCompetitorNotesDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmCompetitorNotesDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmCompetitorNotesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmCompetitorNotesDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmRecruitmentDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmRecruitmentDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmRecruitmentDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmRecruitmentDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmPartnersDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmPartnersDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmPartnersDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmPartnersDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmReportsDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmReportsDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmReportsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmReportsDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmTasksDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmTasksDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmTasksDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmTasksDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmTerritoryGrowthDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmTerritoryGrowthDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmTerritoryGrowthDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmTerritoryGrowthDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmFranchisePipelineDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmFranchisePipelineDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmFranchisePipelineDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmFranchisePipelineDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmLeadsDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmLeadsDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmLeadsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmLeadsDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );
}

class RegionalBdmMeetingsDashboardViewModel extends RegionalBdmDashboardViewModel {
  RegionalBdmMeetingsDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory RegionalBdmMeetingsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      RegionalBdmMeetingsDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: [],
      );

  factory RegionalBdmDashboardViewModel.assemble({required bool isOffline}) {
    return RegionalBdmDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
