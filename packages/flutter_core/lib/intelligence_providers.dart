// Governance - Category: controller | Purpose: Layer: 01_INFRASTRUCTURE Provider for the base IntelligenceService. Resilient provider for Aura Insights. Watches met...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'dashboard_providers.dart';

/// Provider for the base IntelligenceService.
final auraIntelligenceServiceProvider = Provider<IntelligenceService>((ref) {
  final telemetry = ref.watch<ExecutionGateService>(executionGateProvider);
  return IntelligenceService(telemetry);
});

/// Resilient provider for Aura Insights.
/// Watches metrics for the given role and generates AI-driven operational summaries.
final auraInsightsProvider =
    FutureProvider.family<List<IntelligenceInsight>, String>((ref, role) async {
      final service = ref.watch(auraIntelligenceServiceProvider);

      // 1. Await metrics from the resilient dashboard provider
      final result = await ref.watch(dashboardMetricsProvider(role).future);
      final DashboardMetrics metrics = result.fold<DashboardMetrics>(
        (DashboardMetrics data) => data,
        (Object error) => DataLogisticsHub.getDashboardMetrics(role),
      );

      // 2. Synthesize insights
      final insightsResult = await service.generateInsights(role, metrics);
      final insights = insightsResult.fold(
        (data) => data,
        (error) => [
          IntelligenceInsight(
            id: 'error_insight',
            title: 'Aura Synthesis Paused',
            summary:
                'We encountered an anomaly while synthesizing institutional insights. Operational data remains accessible.',
            impact: InsightImpact.info,
          ),
        ],
      );

      // 3. Inject active pulse anomaly if present
      final activeAnomaly = ref.watch(auraActiveAnomalyProvider);
      if (activeAnomaly != null) {
        return [
          IntelligenceInsight(
            id: activeAnomaly.id,
            title: activeAnomaly.title,
            summary: activeAnomaly.description,
            impact: activeAnomaly.impact,
            relatedMetricId:
                activeAnomaly.metadata?['relatedMetricId'] as String?,
          ),
          ...insights,
        ];
      }

      return insights;
    });
