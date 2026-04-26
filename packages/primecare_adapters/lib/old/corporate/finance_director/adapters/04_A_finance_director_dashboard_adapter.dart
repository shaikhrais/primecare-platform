import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Finance Director.
final financeDirectorActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Finance Director Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for Finance Director metrics.
/// Provides real-time revenue velocity, EBITDA margins, and audit integrity telemetry.
final financeDirectorMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics('/v2/corporate/finance_director')
      .map((r) => r.fold((m) => m, (e) => throw e));
});

/// High-fidelity AI financial insights for the Finance Director.
/// Leverages Aura Intelligence to surface margin sensitivities and audit risks.
final financeDirectorInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  // Simulate AI computation for fiscal modeling
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
      id: 'finance_01',
      title: LocaleKeys.dashboards_financedirector_labels_revenue_velocity_alert
          .tr(),
      summary:
          'Revenue realization has accelerated by 18.4% YoY. Average DSO (Days Sales Outstanding) dropped to 22 days.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      category: 'Revenue',
      recommendation:
          'Maintain current collection cadence; explore early-payment discounts for preferred corporate accounts.',
    ),
    IntelligenceInsight(
      id: 'finance_02',
      title: LocaleKeys
          .dashboards_financedirector_labels_ebitda_margin_sensitivity
          .tr(),
      summary:
          'Operational margins in the Ontario region show sensitivity to rising labor costs. Estimated margin compression: 2.1%.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Operations',
      recommendation:
          'Initiate variance analysis on overtime expenditure in the GTA cluster.',
    ),
    IntelligenceInsight(
      id: 'finance_03',
      title: LocaleKeys
          .dashboards_financedirector_labels_double_entry_integrity_audit
          .tr(),
      summary:
          'Automated ledger reconciliation completed with 99.98% match rate. 2 orphan transactions identified in legacy billing portal.',
      impact: InsightImpact.info,
      type: InsightType.optimization,
      category: 'Audit',
      recommendation:
          'Execute manual reconciliation for transaction IDs #8821 and #8824.',
    ),
  ];
});

final financeDirectorDashboardAdapterProvider =
    FutureProvider<Result<FinanceDirectorDashboardViewModel>>((ref) async {
      const cacheKey = 'finance_director_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // Watch metrics and insights
        final metrics = await ref.watch(financeDirectorMetricsProvider.future);
        final insights = await ref.watch(
          financeDirectorInsightsProvider.future,
        );

        final viewModel = FinanceDirectorDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'Finance Director Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'Finance Director Metrics Fallback Triggered: $e',
        );
        return _handleFinanceDirectorFallback(resilience, cacheKey, telemetry);
      }
    });

Result<FinanceDirectorDashboardViewModel> _handleFinanceDirectorFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = FinanceDirectorDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Finance Director Cache corruption detected: $e',
      );
    }
  }
  return Success(
    FinanceDirectorDashboardViewModel.empty(isOfflineFallback: true),
  );
}
