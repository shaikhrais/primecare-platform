import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'intelligence_service.dart';
import 'dashboard_providers.dart';
import 'aura_providers.dart';
import 'src/models/intelligence_insight.dart';
import 'src/factory_floor/data_logistics_hub.dart';

/// Provider for the base IntelligenceService.
final auraIntelligenceServiceProvider = Provider<IntelligenceService>((ref) {
  return IntelligenceService();
});

/// Resilient provider for Aura Insights.
/// Watches metrics for the given role and generates AI-driven operational summaries.
final auraInsightsProvider = FutureProvider.family<List<IntelligenceInsight>, String>((
  ref,
  role,
) async {
  final service = ref.watch(auraIntelligenceServiceProvider);

  // 1. Await metrics from the resilient dashboard provider
  final result = await ref.watch(dashboardMetricsProvider(role).future);
  final metrics = result.fold(
    (data) => data,
    (error) => DataLogisticsHub.getDashboardMetrics(role),
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
        relatedMetricId: activeAnomaly.metadata?['relatedMetricId'],
      ),
      ...insights,
    ];
  }

  return insights;
});
