import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';

class RegionalBdmDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  const RegionalBdmDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
  });

  factory RegionalBdmDashboardViewModel.assemble({required bool isOffline}) {
    return RegionalBdmDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: []),
        const ActivityFeedBlueprint(dataPayload: []),
      ],
    );
  }

  factory RegionalBdmDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return RegionalBdmDashboardViewModel(
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


class RegionalBdmTasksDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmTasksDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmTasksDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmTasksDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class RegionalBdmTerritoryGrowthDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmTerritoryGrowthDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmTerritoryGrowthDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmTerritoryGrowthDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class RegionalBdmSalesDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmSalesDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmSalesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmSalesDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class RegionalBdmReportsDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmReportsDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmReportsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmReportsDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class RegionalBdmRecruitmentDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmRecruitmentDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmRecruitmentDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmRecruitmentDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class RegionalBdmPartnersDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmPartnersDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmPartnersDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmPartnersDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class RegionalBdmDealTrackerDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmDealTrackerDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmDealTrackerDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmDealTrackerDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class RegionalBdmCompetitorNotesDashboardViewModel extends RegionalBdmDashboardViewModel {
  const RegionalBdmCompetitorNotesDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalBdmCompetitorNotesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalBdmCompetitorNotesDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}
