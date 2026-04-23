import 'package:primecare_adapters/primecare_adapters.dart';

final receptionistDashboardAdapterProvider = Provider<AsyncValue<Result<ReceptionistDashboardViewModel>>>((ref) {
  return AsyncValue.data(Result.success(ReceptionistDashboardViewModel(
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
