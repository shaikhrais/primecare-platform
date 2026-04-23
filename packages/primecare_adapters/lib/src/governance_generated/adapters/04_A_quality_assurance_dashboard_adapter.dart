import 'package:primecare_adapters/primecare_adapters.dart';

final qualityAssuranceDashboardAdapterProvider = Provider<AsyncValue<Result<QualityAssuranceDashboardViewModel>>>((ref) {
  return AsyncValue.data(Result.success(QualityAssuranceDashboardViewModel(
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
