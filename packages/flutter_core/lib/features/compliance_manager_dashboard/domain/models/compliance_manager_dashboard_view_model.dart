import 'package:primecare_core/flutter_core.dart';

class ComplianceManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const ComplianceManagerDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
  });

  factory ComplianceManagerDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return ComplianceManagerDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory ComplianceManagerDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    bool isOffline = false,
  }) {
    return ComplianceManagerDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: [
        StatGridBlueprint(
          dataPayload: metrics.kpis
              .map(
                (kpi) => UniversalKpi(
                  title: kpi.title,
                  value: kpi.value,
                  trend: 0.0,
                  status: UniversalKpi.mapStatus(kpi.status),
                ),
              )
              .toList(),
        ),
        const RiskMonitorBlueprint(
          dataPayload: {
            'status': 'WARNING',
            'summary':
                'Elevated compliance risks observed in 2 regional branches. Audit required.',
          },
        ),
        const ComplianceGateBlueprint(
          dataPayload: {
            'gate': 'verified',
            'summary':
                'All mandatory institutional compliance checkpoints are verified and passed for the current quarter.',
          },
        ),
        const StitchBlueprint(
          screenId: '4d5e6f7a8b244705a405113ae8623ec4', // Compliance Dashboard
        ),
      ],
    );
  }

  static ComplianceManagerDashboardViewModel assemble({
    required bool isOffline,
  }) {
    final metrics = DataLogisticsHub.getDashboardMetrics('compliance');
    return ComplianceManagerDashboardViewModel.fromDashboardMetrics(
      metrics,
      isOffline: isOffline,
    );
  }
}
