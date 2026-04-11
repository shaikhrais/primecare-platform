import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';

class FranchiseDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  const FranchiseDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
  });

  factory FranchiseDashboardViewModel.assemble({required bool isOffline}) {
    return FranchiseDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: []),
        const ActivityFeedBlueprint(dataPayload: []),
      ],
    );
  }

  factory FranchiseDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return FranchiseDashboardViewModel(
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


class FranchiseClaimsDashboardViewModel extends FranchiseDashboardViewModel {
  const FranchiseClaimsDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory FranchiseClaimsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = FranchiseDashboardViewModel.fromDashboardMetrics(metrics);
    return FranchiseClaimsDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class FranchiseInvoicesDashboardViewModel extends FranchiseDashboardViewModel {
  const FranchiseInvoicesDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory FranchiseInvoicesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = FranchiseDashboardViewModel.fromDashboardMetrics(metrics);
    return FranchiseInvoicesDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class FranchiseOutstandingBalancesDashboardViewModel extends FranchiseDashboardViewModel {
  const FranchiseOutstandingBalancesDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory FranchiseOutstandingBalancesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = FranchiseDashboardViewModel.fromDashboardMetrics(metrics);
    return FranchiseOutstandingBalancesDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}


class FranchisePaymentsDashboardViewModel extends FranchiseDashboardViewModel {
  const FranchisePaymentsDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory FranchisePaymentsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    final base = FranchiseDashboardViewModel.fromDashboardMetrics(metrics);
    return FranchisePaymentsDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}
