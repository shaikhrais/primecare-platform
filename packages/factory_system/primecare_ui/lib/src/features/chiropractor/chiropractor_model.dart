import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ChiropractorViewModel extends PrimeCareDashboardViewModel {
  const ChiropractorViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ChiropractorViewModel.empty() {
    return ChiropractorViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }

  factory ChiropractorViewModel.initial() {
    return ChiropractorViewModel(
      metrics: DashboardMetrics(
        kpis: [
          KpiMetric(
            title: 'Spinal Adjustments',
            value: '42',
            status: 'positive',
            trend: '+15%',
          ),
          KpiMetric(
            title: 'New Patients',
            value: '12',
            status: 'neutral',
          ),
          KpiMetric(
            title: 'Recovery Rate',
            value: '88%',
            status: 'positive',
          ),
        ],
        recentActivity: [],
      ),
      insights: [
        IntelligenceInsight(
          id: 'recovery_rate_insight',
          title: 'High Recovery Rate',
          summary: 'High recovery rate observed in cervical spine patients.',
          impact: InsightImpact.positive,
        ),
      ],
    );
  }
}
