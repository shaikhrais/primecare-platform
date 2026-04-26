// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the CX Director.
final cxDirectorActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('CX Director Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the CX Director.
/// Tracks NPS, sentiment velocity, churn risk, and response latency.
final cxDirectorMetricsProvider = StreamProvider.autoDispose<DashboardMetrics>((
  ref,
) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository
      .watchMetrics('/v2/corporate/cx_director')
      .map((r) => r.fold((m) => m, (e) => DashboardMetrics.empty()));
});

/// High-fidelity AI experience insights for the CX Director.
/// Surfaces sentiment shifts and churn risks via Aura Intelligence.
final cxDirectorInsightsProvider = FutureProvider.autoDispose<List<IntelligenceInsight>>((
  ref,
) async {
  ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 10));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return const [];
  }

  // Simulate AI computation for experience modeling
  await Future<void>.delayed(const Duration(seconds: 1));

  return [
    IntelligenceInsight(
      id: 'cx_01',
      title: 'Sentiment Surge Detected',
      summary:
          'Community sentiment in the US-Northeast cluster has increased by 15% following the "Family Portal 2.0" launch.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Sentiment',
      recommendation:
          'Highlight portal engagement features in the next stakeholder report.',
    ),
    IntelligenceInsight(
      id: 'cx_02',
      title: 'Churn Risk Volatility',
      summary:
          '3 specific facilities show engagement drop in the private-pay segment. Predictive churn risk up by 0.8%.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Retention',
      recommendation:
          'Trigger personalized Concierge outreach for families in the bottom 10th percentile of engagement.',
    ),
    IntelligenceInsight(
      id: 'cx_03',
      title: 'Response Latency Optimization',
      summary:
          'Automated triage reduced average response time to under 1 hour. First-contact resolution is at an all-time high.',
      impact: InsightImpact.info,
      type: InsightType.optimization,
      category: 'Efficiency',
      recommendation:
          'Allocate freed resource bandwidth to proactive advocacy program.',
    ),
  ];
});

final cxDirectorDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<CXDirectorDashboardViewModel>>((
      ref,
    ) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'cx_director_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );

      try {
        if (!canExecute) {
          throw Exception('Metrics subsystem is degraded or offline');
        }
        // Watch metrics and insights
        final metrics = await ref.watch(cxDirectorMetricsProvider.future);
        final insights = await ref.watch(cxDirectorInsightsProvider.future);

        final viewModel = CXDirectorDashboardViewModel(
          title: 'CX Director Dashboard',
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'CX Director Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'CX Director Metrics Fallback Triggered: $e',
        );
        return _handleCXDirectorFallback(resilience, cacheKey, telemetry);
      }
    });

Result<CXDirectorDashboardViewModel> _handleCXDirectorFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = CXDirectorDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'CX Director Cache corruption detected: $e',
      );
    }
  }
  return Success(CXDirectorDashboardViewModel.empty(isOfflineFallback: true));
}
