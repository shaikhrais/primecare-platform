import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'intelligence_service.dart';
import 'dashboard_providers.dart';
import 'aura_providers.dart';
import 'src/models/intelligence_insight.dart';

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
  final metrics = await ref.watch(dashboardMetricsProvider(role).future);

  // 2. Synthesize insights
  try {
    final insights = await service.generateInsights(role, metrics);

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
  } catch (e) {
    // Fallback: If intelligence computation fails, return an informative error insight
    return [
      IntelligenceInsight(
        id: 'error_insight',
        title: 'Aura Synthesis Paused',
        summary:
            'We encountered an anomaly while synthesizing institutional insights. Operational data remains accessible.',
        impact: InsightImpact.info,
      ),
    ];
  }
});
