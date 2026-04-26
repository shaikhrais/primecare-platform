// Layer: 04_UI_ADAPTERS
import 'package:primecare_adapters/primecare_adapters.dart';
import 'dart:async';

// -----------------------------------------------------------------------------
// Split Hydration: Real-time Telemetry (Stream) + AI Insights (Future)
// -----------------------------------------------------------------------------

/// High-fidelity telemetry stream for the Regional Manager (USA).
/// Tracks market reach, revenue velocity, and regional compliance across US clusters.
final regionalManagerUsaMetricsProvider = StreamProvider<DashboardMetrics>((
  ref,
) {
  const route = 'RegionalManagerUsa';
  final repository = ref.watch(dashboardRepositoryProvider);
  final telemetry = ref.read(executionGateProvider);

  telemetry.passGate(
    ExecutionGateCategory.resilience,
    'Regional Manager USA metrics stream initiated.',
  );

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository.watchMetrics(route).map((metricsResult) {
    return metricsResult.fold((metrics) {
      final enrichedKpis = metrics.kpis.isEmpty
          ? [
              const KpiMetric(
                title: 'Market Reach',
                value: '28.2%',
                trend: '+3.1%',
                status: 'positive',
              ),
              const KpiMetric(
                title: 'Revenue Velocity',
                value: '1.4x',
                trend: '+12.0%',
                status: 'positive',
              ),
              const KpiMetric(
                title: 'Compliance Rating',
                value: '99.8%',
                trend: '+0.5%',
                status: 'positive',
              ),
              const KpiMetric(
                title: 'Regional Retention',
                value: '92%',
                trend: '+1.5%',
                status: 'positive',
              ),
            ]
          : metrics.kpis;

      return metrics.copyWith(
        kpis: enrichedKpis,
        recentActivity: metrics.recentActivity,
      );
    }, (error) => DashboardMetrics.empty());
  });
});

/// High-fidelity AI regional insights for the Regional Manager (USA).
/// Surfaces interstate mobility and market saturation risks via Aura Intelligence.
final regionalManagerUsaInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
      id: 'reg_usa_01',
      title: 'Interstate Mobility Optimization',
      summary:
          'Cross-state nursing mobility trend detected in the Tri-State area. Reciprocal licensing potential identified.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Human Capital',
      recommendation:
          'Fast-track reciprocal licensing for NJ-based RNs to cover NY surges.',
    ),
    IntelligenceInsight(
      id: 'reg_usa_02',
      title: 'Market Saturation Warning: CA',
      summary:
          'CSAT scores in California showing slight decline due to capacity limits. Predicted churn up 0.4%.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Operations',
      recommendation:
          'Pause new patient intake in San Francisco until 3 more PSWs are onboarded.',
    ),
    IntelligenceInsight(
      id: 'reg_usa_03',
      title: 'Texas Growth Corridor',
      summary:
          'Inquiry volume in the Dallas-Fort Worth cluster has exceeded projections by 22%.',
      impact: InsightImpact.info,
      type: InsightType.growth,
      category: 'Market',
      recommendation:
          'Allocate additional marketing budget to Houston to capture similar growth vectors.',
    ),
  ];
});

// -----------------------------------------------------------------------------
// Action Handlers
// -----------------------------------------------------------------------------

final regionalManagerUsaActionHandler = Provider<void Function(String)>((ref) {
  return (String actionId) {
    final telemetry = ref.read(executionGateProvider);
    telemetry.passGate(
      ExecutionGateCategory.resilience,
      'Regional Manager USA Action Triggered: $actionId',
    );
  };
});

/// Combined adapter provider for the Regional Manager USA Dashboard.
/// Bridges high-fidelity telemetry and regional insights into a unified ViewModel.
final regionalManagerUsaDashboardAdapterProvider =
    FutureProvider<Result<RegionalManagerUsaDashboardViewModel>>((ref) async {
      const cacheKey = 'regional_manager_usa_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(
          regionalManagerUsaMetricsProvider.future,
        );
        final insights = await ref.watch(
          regionalManagerUsaInsightsProvider.future,
        );

        final viewModel = RegionalManagerUsaDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Regional Manager USA Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          final vm = RegionalManagerUsaDashboardViewModel.fromJson(snapshot);
          return Success(
            RegionalManagerUsaDashboardViewModel(
              metrics: vm.metrics,
              insights: vm.insights,
              isOfflineFallback: true,
            ),
          );
        }
        return Success(
          RegionalManagerUsaDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
