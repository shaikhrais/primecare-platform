// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final rnDashboardAdapterProvider = FutureProvider<Result<RnDashboardViewModel>>((
  ref,
) async {
  final resilience = ref.read(resilienceServiceProvider);
  const cacheKey = 'rn_dashboard';
  final telemetry = ref.read(executionGateProvider);

  try {
    // 1. Adaptive Telemetry Injection
    final metrics = DashboardMetrics(
      kpis: [
        const KpiMetric(
          title: 'Active Patients',
          value: '28',
          status: 'success',
        ),
        const KpiMetric(
          title: 'High Acuity',
          value: '3',
          trend: 'up',
          status: 'danger',
        ),
        const KpiMetric(
          title: 'Med Compliance',
          value: '100%',
          status: 'success',
        ),
        const KpiMetric(
          title: 'Charting Gap',
          value: '12m',
          trend: 'down',
          status: 'success',
        ),
      ],
      recentActivity: [],
      charts: [
        AnalyticsChart(
          id: 'vital-stability',
          title: 'Vital Stability Index (24h Aggregate)',
          type: ChartType.line,
          labels: const ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00'],
          datasets: [],
          dataPoints: [
            const ChartDataPoint(label: '00:00', value: 92),
            const ChartDataPoint(label: '04:00', value: 90),
            const ChartDataPoint(label: '08:00', value: 95),
            const ChartDataPoint(label: '12:00', value: 94),
            const ChartDataPoint(label: '16:00', value: 96),
            const ChartDataPoint(label: '20:00', value: 93),
          ],
        ),
      ],
    );

    final insights = [
      IntelligenceInsight(
        id: 'rn_1',
        title: 'Deterioration Early Warning',
        summary:
            'Patient #8821 showing early signs of respiratory distress (RR > 24).',
        impact: InsightImpact.high,
        type: InsightType.alert,
        category: 'Clinical',
        recommendation: 'Assess patient immediately and notify physician.',
      ),
      IntelligenceInsight(
        id: 'rn_2',
        title: 'Medication Safety Streak',
        summary:
            'Unit has achieved 14 consecutive days without a medication administration error.',
        impact: InsightImpact.low,
        type: InsightType.efficiency,
        category: 'Safety',
        recommendation: 'Share success at next unit huddle.',
      ),
    ];

    final viewModel = RnDashboardViewModel(
      metrics: metrics,
      insights: insights,
      isOfflineFallback: false,
    );

    // 2. Resilience Persistence
    unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

    telemetry.passGate(
      ExecutionGateCategory.clinical,
      'RN Dashboard Hydrated (Live)',
    );

    return Success(viewModel);
  } catch (e) {
    // 3. Resilience Recovery
    final cachedData = resilience.getSnapshot(cacheKey);
    if (cachedData != null) {
      return Success(
        RnDashboardViewModel.fromJson(
          cachedData,
        ).copyWith(isOfflineFallback: true),
      );
    }
    return Success(RnDashboardViewModel.empty(isOfflineFallback: true));
  }
});
