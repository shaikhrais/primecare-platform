import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class FranchiseDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;
  
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<dynamic> alerts;

  FranchiseDashboardViewModel({
    required this.kpis,
    this.recentActivity = const [],
    this.alerts = const [],
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory FranchiseDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return FranchiseDashboardViewModel(
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
}

class FranchiseClaimsDashboardViewModel extends FranchiseDashboardViewModel {
  FranchiseClaimsDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory FranchiseClaimsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      FranchiseClaimsDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: FranchiseDashboardViewModel._generateBlueprints(metrics),
      );
}

class FranchiseInvoicesDashboardViewModel extends FranchiseDashboardViewModel {
  FranchiseInvoicesDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory FranchiseInvoicesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      FranchiseInvoicesDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: FranchiseDashboardViewModel._generateBlueprints(metrics),
      );
}

class FranchiseOutstandingBalancesDashboardViewModel extends FranchiseDashboardViewModel {
  FranchiseOutstandingBalancesDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory FranchiseOutstandingBalancesDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      FranchiseOutstandingBalancesDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: FranchiseDashboardViewModel._generateBlueprints(metrics),
      );
}

class FranchisePaymentsDashboardViewModel extends FranchiseDashboardViewModel {
  FranchisePaymentsDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory FranchisePaymentsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      FranchisePaymentsDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: FranchiseDashboardViewModel._generateBlueprints(metrics),
      );
}

class FranchiseRefundsDashboardViewModel extends FranchiseDashboardViewModel {
  FranchiseRefundsDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory FranchiseRefundsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      FranchiseRefundsDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: FranchiseDashboardViewModel._generateBlueprints(metrics),
      );
}

class FranchiseReportsDashboardViewModel extends FranchiseDashboardViewModel {
  FranchiseReportsDashboardViewModel({required super.kpis, super.recentActivity, super.alerts, super.isOfflineFallback, super.blueprints});
  factory FranchiseReportsDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) =>
      FranchiseReportsDashboardViewModel(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        blueprints: FranchiseDashboardViewModel._generateBlueprints(metrics),
      );
}
