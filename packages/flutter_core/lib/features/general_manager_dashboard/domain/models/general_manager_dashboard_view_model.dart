import 'package:primecare_core/flutter_core.dart';

class GeneralManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const GeneralManagerDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory GeneralManagerDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return GeneralManagerDashboardViewModel(
      isOfflineFallback: false,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: _buildBlueprints(metrics.kpis, metrics.recentActivity),
    );
  }

  factory GeneralManagerDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return GeneralManagerDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory GeneralManagerDashboardViewModel.assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('general_manager');
    return GeneralManagerDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: _buildBlueprints(metrics.kpis, metrics.recentActivity),
    );
  }

  static List<UIComponentBlueprint> _buildBlueprints(
    List<KpiMetric> kpis,
    List<DashboardActivity> recentActivity,
  ) {
    final universalKpis = kpis
        .map(
          (k) => UniversalKpi(
            title: k.title,
            value: k.value,
            trend: double.tryParse(k.trend?.replaceAll('%', '') ?? '0') ?? 0.0,
            status: UniversalKpi.mapStatus(k.status),
          ),
        )
        .toList();

    return [
      StatGridBlueprint(dataPayload: universalKpis),
      const ManagementActionBlueprint(
        dataPayload: {
          'title': 'Operational Approvals',
          'actions': [
            {'label': 'Approve Budget Shift', 'urgency': 'medium'},
            {'label': 'Sign Off Payroll', 'urgency': 'high'},
            {'label': 'Review Vendor Contract', 'urgency': 'normal'},
          ],
        },
      ),
      ActivityFeedBlueprint(
        dataPayload: recentActivity.map((e) => e.toJson()).toList(),
      ),
      const StitchBlueprint(
        screenId: 'b2b19469e4724705a405113ae8623ec2',
      ), // Example generic GM screen
    ];
  }
}
