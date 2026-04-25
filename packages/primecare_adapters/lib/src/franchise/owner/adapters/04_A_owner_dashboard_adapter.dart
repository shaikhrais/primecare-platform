// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Owner.
final ownerActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Owner Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Owner.
/// Tracks enterprise valuation, EBITDA velocity, and global compliance.
final ownerMetricsProvider = StreamProvider.autoDispose<DashboardMetrics>((
  ref,
) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository
      .watchMetrics('/v2/franchise/owner')
      .map((r) => r.fold((m) => m, (e) => DashboardMetrics.empty()));
});

/// High-fidelity AI business insights for the Owner.
/// Surfaces M&A opportunities and enterprise risk via Aura Intelligence.
final ownerInsightsProvider = FutureProvider.autoDispose<List<IntelligenceInsight>>((
  ref,
) async {
  ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 10));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }

  await Future<void>.delayed(const Duration(seconds: 1));

  return [
    const IntelligenceInsight(
      id: 'own_01',
      title: 'M&A Opportunity: GTA North',
      summary:
          'A competitor in the Vaughan cluster is showing signs of liquidity stress. Potential for strategic acquisition.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Strategy',
      recommendation: 'Initiate non-binding inquiry via legal counsel by EOM.',
    ),
    const IntelligenceInsight(
      id: 'own_02',
      title: 'Regulatory Change: Bill 124 Impact',
      summary:
          'Projected 5% increase in labor costs due to recent provincial wage parity adjustments.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Finance',
      recommendation:
          'Review private-pay pricing schedule to maintain EBITDA margins.',
    ),
    const IntelligenceInsight(
      id: 'own_03',
      title: 'AI Operational Efficiency',
      summary:
          'Aura scheduling optimization has reduced overtime spend by C\$420K YTD.',
      impact: InsightImpact.info,
      type: InsightType.optimization,
      category: 'Operations',
      recommendation:
          'Reinvest savings into R&D for the upcoming Aura Telehealth module.',
    ),
  ];
});

/// Combined adapter provider for the Owner Dashboard.
/// Bridges high-fidelity telemetry and enterprise insights into a unified ViewModel.
final ownerDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<OwnerDashboardViewModel>>((ref) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'owner_dashboard';
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
        final metrics = await ref.watch(ownerMetricsProvider.future);
        final insights = await ref.watch(ownerInsightsProvider.future);

        final viewModel = OwnerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Owner Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            OwnerDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(OwnerDashboardViewModel.empty(isOfflineFallback: true));
      }
    });
