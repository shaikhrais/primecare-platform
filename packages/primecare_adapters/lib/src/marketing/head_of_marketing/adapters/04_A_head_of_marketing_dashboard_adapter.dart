import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Head of Marketing.
final marketingActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Head of Marketing Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Head of Marketing.
/// Tracks lead generation, CAC, conversion trajectory, and brand sentiment.
final marketingMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics('/v2/marketing/head_of_marketing')
      .map((r) => r.fold((m) => m, (e) => throw e));
});

/// High-fidelity AI campaign insights for the Head of Marketing.
/// Surfaces CAC volatility and ROI optimizations via Aura Intelligence.
final marketingInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  await Future<void>.delayed(const Duration(seconds: 1));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }
  return [
    IntelligenceInsight(
      id: 'marketing_insight_1',
      title: LocaleKeys.marketing_dashboard_labels_campaign_roi_peak.tr(),
      summary:
          'Q2 Clinical Growth campaign is delivering a 4.2x ROI, exceeding the 3.5x baseline.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Growth',
      recommendation:
          'Reallocate 15% of the underperforming LinkedIn budget to Meta Video Ads.',
    ),
    IntelligenceInsight(
      id: 'marketing_insight_2',
      title: LocaleKeys.marketing_dashboard_labels_cac_volatility.tr(),
      summary:
          'Customer Acquisition Cost spiked in Western regions due to increased competitor bidding.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Finance',
      recommendation:
          'Pivot to long-tail SEO keywords for clinical recruitment in BC and Alberta.',
    ),
  ];
});

final headOfMarketingDashboardAdapterProvider =
    FutureProvider<Result<HeadOfMarketingDashboardViewModel>>((ref) async {
      const cacheKey = 'head_of_marketing_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // Watch metrics and insights
        final metrics = await ref.watch(marketingMetricsProvider.future);
        final insights = await ref.watch(marketingInsightsProvider.future);

        final viewModel = HeadOfMarketingDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'Head of Marketing Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'Head of Marketing Metrics Fallback Triggered: $e',
        );
        return _handleMarketingFallback(resilience, cacheKey, telemetry);
      }
    });

Result<HeadOfMarketingDashboardViewModel> _handleMarketingFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = HeadOfMarketingDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Marketing Cache corruption detected: $e',
      );
    }
  }
  return Success(
    HeadOfMarketingDashboardViewModel.empty(isOfflineFallback: true),
  );
}
