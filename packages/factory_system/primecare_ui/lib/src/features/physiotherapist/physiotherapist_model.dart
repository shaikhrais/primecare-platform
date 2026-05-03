import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class PhysiotherapistViewModel extends PrimeCareDashboardViewModel {
  const PhysiotherapistViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory PhysiotherapistViewModel.empty() {
    return PhysiotherapistViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }

  factory PhysiotherapistViewModel.initial() {
    return PhysiotherapistViewModel(
      metrics: DashboardMetrics(
        kpis: [
          KpiMetric(
            title: 'Mobility Sessions',
            value: '156',
            status: 'positive',
            trend: '+8%',
          ),
          KpiMetric(
            title: 'Avg Recovery Time',
            value: '14 days',
            status: 'neutral',
          ),
          KpiMetric(
            title: 'Patient Satisfaction',
            value: '4.9/5',
            status: 'success',
          ),
        ],
        recentActivity: [],
      ),
      insights: [
        IntelligenceInsight(
          id: 'mobility_insight',
          title: 'Increased Rehab Volume',
          summary: 'Knee rehabilitation sessions increased by 20% this month.',
          impact: InsightImpact.growth,
        ),
      ],
    );
  }
}
