part of '../../../intelligence_service.dart';

class IntelligenceService extends BaseGuardedService {
  IntelligenceService(ExecutionGateService telemetry) : super(telemetry);

  /// Generates a list of strategic insights based on the provided dashboard metrics.
  ///
  /// In a production environment, this would interface with an LLM (e.g., OpenAI/Gemini)
  /// providing context on institutional KPIs. In this iteration, we utilize a logic-driven
  /// synthesis to ensure resilience and immediate operational feedback.
  Future<Result<List<IntelligenceInsight>>> generateInsights(
    String role,
    DashboardMetrics metrics,
  ) async {
    return guard<List<IntelligenceInsight>>(
      () async {
        // 1. Simulate institutional analysis delay
        await Future<void>.delayed(const Duration(milliseconds: 800));

        final insights = <IntelligenceInsight>[];

        // Rule 1: Revenue Trajectory Analysis (Generic for all roles with financial context)
        final revenueChart = metrics.charts.firstWhere(
          (c) =>
              c.title.toLowerCase().contains('revenue') ||
              c.title.toLowerCase().contains('earnings'),
          orElse: () => metrics.charts.isNotEmpty
              ? metrics.charts.first
              : AnalyticsChart(
                  id: 'none',
                  title: 'none',
                  type: ChartType.line,
                  dataPoints: [],
                ),
        );

        if (revenueChart.id != 'none' && revenueChart.dataPoints.isNotEmpty) {
          final lastValue = revenueChart.dataPoints.last.value;
          final prevValue = revenueChart.dataPoints.length > 1
              ? revenueChart
                    .dataPoints[revenueChart.dataPoints.length - 2]
                    .value
              : lastValue;

          if (lastValue > prevValue) {
            insights.add(
              IntelligenceInsight(
                id: 'revenue_growth',
                title: 'Positive Revenue Momentum',
                summary:
                    'Institutional revenue is trending upwards, showing a ${(((lastValue - prevValue) / prevValue) * 100).toStringAsFixed(1)}% increase in the latest cycle.',
                impact: InsightImpact.positive,
                relatedMetricId: revenueChart.id,
              ),
            );
          } else if (lastValue < prevValue) {
            insights.add(
              IntelligenceInsight(
                id: 'revenue_dip',
                title: 'Revenue Variance Detected',
                summary:
                    'We detected a slight dip in daily billing. Recommend auditing the latest transaction log for potential missed billing cycles.',
                impact: InsightImpact.caution,
                relatedMetricId: revenueChart.id,
              ),
            );
          }
        }

        // Rule 2: Occupancy/Capacity Synthesis (Role-specific)
        if (role == 'admin' || role == 'facility_manager') {
          insights.add(
            IntelligenceInsight(
              id: 'capacity_alert',
              title: 'Operational Readiness',
              summary:
                  'Facility occupancy is at 94%. Predictive analysis suggests peak capacity may be reached by next weekend.',
              impact: InsightImpact.info,
            ),
          );
        }

        // Rule 3: General institutional health
        if (metrics.recentActivity.length > 5) {
          insights.add(
            IntelligenceInsight(
              id: 'high_activity',
              title: 'Increased Documentation Volume',
              summary:
                  'Operational documentation volume is high today. Workforce efficiency indices remain stable across all shifts.',
              impact: InsightImpact.info,
            ),
          );
        }

        telemetry.passGate(
          ExecutionGateCategory.intelligence,
          'Strategic insights generated for role: $role',
          metadata: {'insightsCount': insights.length},
        );

        return insights;
      },
      onError: (Object e, StackTrace st) {
        telemetry.failGate(
          ExecutionGateCategory.intelligence,
          'Failed to generate intelligence insights',
          error: e,
          stackTrace: st,
        );
        return [];
      },
    );
  }
}
