// Layer: 04_UI_ADAPTERS
import '../../primecare_adapters.dart';
import '../models/core/intelligence_dashboard_model.dart';

/// Provider for the generic [DynamicScreenAdapter].
/// Allows any UI component to dynamically hydrate its data by role/form.
final dynamicAdapterProvider =
    Provider.family<DynamicScreenAdapter, PrimeCareForm>((ref, form) {
      return DynamicScreenAdapter(ref, form);
    });

/// Internal helper to securely fetch telemetry and map to PrimeCareDashboardViewModel
Future<Result<PrimeCareDashboardViewModel>> _fetchResilientDashboard(
  Ref ref,
  PrimeCareForm form,
) async {
  try {
    // 1. Fetch live metrics from the unified telemetry endpoint
    final response = await ref.read(apiClientProvider).get(
      '/dashboard-metrics',
      query: {'role': form.name},
    );
    final data = response.data as Map<String, dynamic>;

    // 2. Map payload cleanly using IntelligenceDashboardModel as the serialization layer
    final metricsRaw = data['metrics'] ?? data['kpis'] ?? <dynamic>[];
    final insightsRaw = data['insights'] ?? <dynamic>[];
    final timelineRaw = data['timeline'] ?? data['recentActivity'] ?? <dynamic>[];
    final trendsRaw = data['trends'] ?? data['charts'] ?? <dynamic>[];
    final isFallback = data['isOfflineFallback'] ?? false;

    final intlModel = IntelligenceDashboardModel.fromJson({
      'metrics': metricsRaw,
      'insights': insightsRaw,
      'timeline': timelineRaw,
      'trends': trendsRaw,
      'isOfflineFallback': isFallback,
      'lastUpdated': DateTime.now().toIso8601String(),
    });

    // 3. Translate from precision model to generic ViewModel used by generic screens
    final dashboardMetrics = DashboardMetrics(
      kpis: intlModel.metrics,
      recentActivity: intlModel.timeline,
      charts: intlModel.trends,
      insights: intlModel.insights,
      isOfflineFallback: intlModel.isFromCache,
    );

    final mappedInsights = intlModel.insights
        .map((e) => IntelligenceInsight.fromDashboardInsight(e))
        .toList();

    return Success(
      PrimeCareDashboardViewModel(
        metrics: dashboardMetrics,
        insights: mappedInsights,
        isOfflineFallback: intlModel.isFromCache,
      ),
    );
  } catch (e) {
    // 4. Resilience Fallback if network and mock interceptor fail entirely
    return Success(PrimeCareDashboardViewModel.empty(isOfflineFallback: true));
  }
}

/// A generic future provider that returns a live telemetry view model for any form.
final genericDashboardAdapterProvider =
    FutureProvider.family<Result<PrimeCareDashboardViewModel>, PrimeCareForm>((
      ref,
      form,
    ) async {
      return _fetchResilientDashboard(ref, form);
    });

/// Specialized fallback for Workflow & Form screens.
final workflowFormsAdapterProvider =
    FutureProvider.family<Result<PrimeCareDashboardViewModel>, PrimeCareForm>((
      ref,
      form,
    ) async {
      return _fetchResilientDashboard(ref, form);
    });

/// Specialized fallback for Operational Insight screens.
final operationalInsightAdapterProvider =
    FutureProvider.family<Result<PrimeCareDashboardViewModel>, PrimeCareForm>((
      ref,
      form,
    ) async {
      return _fetchResilientDashboard(ref, form);
    });

/// Specialized fallback for Infrastructure & Admin screens.
final infrastructureMonitoringAdapterProvider =
    FutureProvider.family<Result<PrimeCareDashboardViewModel>, PrimeCareForm>((
      ref,
      form,
    ) async {
      return _fetchResilientDashboard(ref, form);
    });
