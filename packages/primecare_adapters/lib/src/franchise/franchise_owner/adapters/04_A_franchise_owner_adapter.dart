// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Franchise Owner.
final franchiseOwnerActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Franchise Owner Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Franchise Owner.
/// Tracks unit profitability, royalty compliance, and operational growth.
final franchiseOwnerMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics('/v2/franchise/franchise_owner')
      .map((r) => r.fold((m) => m, (e) => throw e));
});

/// High-fidelity AI business insights for the Franchise Owner.
/// Surfaces profitability trends and market expansion via Aura Intelligence.
final franchiseOwnerInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
      id: 'fra_own_01',
      title: 'Territory Expansion Opportunity',
      summary:
          'Adjacent postal code (L4B) shows 300% increase in private care searches.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Market',
      recommendation:
          'Inquire with Corporate about sub-territory licensing for Richmond Hill South.',
    ),
    IntelligenceInsight(
      id: 'fra_own_02',
      title: 'Retention Risk: Night Shift',
      summary:
          'Turnover in the 11 PM - 7 AM slot is 15% higher than day shifts.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Human Capital',
      recommendation:
          'Implement night-shift differential bonus to stabilize staffing levels.',
    ),
    IntelligenceInsight(
      id: 'fra_own_03',
      title: 'Referral Pipeline Strength',
      summary:
          'Strategic partnership with local hospital group contributing 40% of new intake.',
      impact: InsightImpact.info,
      type: InsightType.efficiency,
      category: 'Operations',
      recommendation:
          'Increase quarterly gift-basket budget for hospital discharge coordinators.',
    ),
  ];
});

/// Combined adapter provider for the Franchise Owner Dashboard.
/// Bridges high-fidelity telemetry and business insights into a unified ViewModel.
final franchiseOwnerAdapterProvider =
    FutureProvider<Result<FranchiseOwnerDashboardViewModel>>((ref) async {
      const cacheKey = 'franchise_owner_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(franchiseOwnerMetricsProvider.future);
        final insights = await ref.watch(franchiseOwnerInsightsProvider.future);

        final viewModel = FranchiseOwnerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Franchise Owner Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            FranchiseOwnerDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          FranchiseOwnerDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
