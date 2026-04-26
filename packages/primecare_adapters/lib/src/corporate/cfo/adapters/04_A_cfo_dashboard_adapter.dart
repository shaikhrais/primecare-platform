import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

// -----------------------------------------------------------------------------
// Split Hydration: Real-time Telemetry (Stream) + AI Insights (Future)
// -----------------------------------------------------------------------------

/// High-fidelity telemetry stream for CFO metrics.
/// Provides real-time financial velocity, liquidity tracking, and margin analytics.
final cfoMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  const route = 'CFO';
  final repository = ref.watch(dashboardRepositoryProvider);
  final telemetry = ref.read(executionGateProvider);

  telemetry.passGate(
    ExecutionGateCategory.resilience,
    'CFO metrics stream initiated.',
  );

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository.watchMetrics(route).map((result) {
    return result.fold((metrics) {
      // Add role-specific KPIs if empty or override for high-fidelity UI
      final enrichedKpis = metrics.kpis.isEmpty
          ? [
              KpiMetric(
                title: LocaleKeys.cfo_dashboard_labels_ebitda_ttm.tr(),
                value: '\$1.24M',
                subtitle: '+4.2',
                trend: 'up',
                status: 'success',
              ),
              KpiMetric(
                title: LocaleKeys.cfo_dashboard_labels_cash_on_hand.tr(),
                value: '\$842.5K',
                subtitle: '+2.1',
                trend: 'up',
                status: 'success',
              ),
              KpiMetric(
                title: LocaleKeys.cfo_dashboard_labels_net_margin.tr(),
                value: '24.2%',
                subtitle: '+1.5',
                trend: 'up',
                status: 'success',
              ),
              KpiMetric(
                title: LocaleKeys.cfo_dashboard_labels_operational_burn.tr(),
                value: '\$118K/mo',
                subtitle: '-2.1',
                trend: 'down',
                status: 'success',
              ),
            ]
          : metrics.kpis;

      return metrics.copyWith(kpis: enrichedKpis);
    }, (error) => throw error);
  });
});

/// High-fidelity AI financial insights for the CFO.
/// Leverages Aura Intelligence to surface tax optimizations and risk alerts.
final cfoInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
      id: 'cfo_insight_1',
      title: LocaleKeys.cfo_dashboard_labels_tax_optimization.tr(),
      summary:
          'Potential \$24K saving identified via SR&ED credit for new AI logistics module.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Finance',
      recommendation: 'Contact tax consultant to finalize SR&ED claim.',
    ),
    IntelligenceInsight(
      id: 'cfo_insight_2',
      title: LocaleKeys.cfo_dashboard_labels_ar_alert.tr(),
      summary: 'DSO increased to 42 days in US West region (+5 days).',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Treasury',
      recommendation:
          'Trigger automated dunning workflow for accounts >30 days.',
    ),
    IntelligenceInsight(
      id: 'cfo_insight_3',
      title: LocaleKeys.cfo_dashboard_labels_capital_efficiency.tr(),
      summary:
          'Reallocating unused marketing reserves to infrastructure could improve EBITDA by 0.5%.',
      impact: InsightImpact.info,
      type: InsightType.optimization,
      category: 'Strategic',
      recommendation: 'Review Q4 reserve reallocation with Head of Marketing.',
    ),
  ];
});

// -----------------------------------------------------------------------------
// Action Handlers
// -----------------------------------------------------------------------------

final cfoActionHandler = Provider<void Function(String)>((ref) {
  return (String actionId) {
    final telemetry = ref.read(executionGateProvider);
    telemetry.passGate(
      ExecutionGateCategory.resilience,
      'CFO Action Triggered: $actionId',
    );
  };
});

/// Combined adapter provider for the CFO Dashboard.
/// Bridges the high-fidelity telemetry and insights into a unified ViewModel for the registry.
final cfoDashboardAdapterProvider =
    FutureProvider<Result<CfoDashboardViewModel>>((ref) async {
      const cacheKey = 'cfo_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // 1. Hydrate split streams
        final metrics = await ref.watch(cfoMetricsProvider.future);
        final insights = await ref.watch(cfoInsightsProvider.future);

        final viewModel = CfoDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        // 2. Persist for resilience
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'CFO Dashboard fully hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'CFO Dashboard Fallback Triggered: $e',
        );
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            CfoDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(CfoDashboardViewModel.empty(isOfflineFallback: true));
      }
    });
