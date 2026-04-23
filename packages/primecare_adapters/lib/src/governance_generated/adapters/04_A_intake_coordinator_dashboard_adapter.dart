import 'package:primecare_adapters/primecare_adapters.dart';

final intakeCoordinatorDashboardAdapterProvider = Provider<AsyncValue<Result<IntakeCoordinatorDashboardViewModel>>>((ref) {
  return AsyncValue.data(Result.success(IntakeCoordinatorDashboardViewModel(
    metrics: const DashboardMetrics(
      kpis: [
        KpiMetric(title: 'Governance Status', value: 'Operational', trend: '0%', status: 'positive'),
        KpiMetric(title: 'Realization Score', value: '100%', trend: '5%', status: 'positive'),
      ],
      recentActivity: [],
    ),
    insights: const [],
  )));
});
