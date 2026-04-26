// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// StreamProvider for real-time scheduling metrics.
/// Implements high-fidelity hydration for the Scheduler/Coordinator.
final schedulerMetricsProvider = StreamProvider.autoDispose<DashboardMetrics>((
  ref,
) {
  const route = 'SCHEDULER';
  final repository = ref.read(dashboardRepositoryProvider);

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics(route)
      .map(
        (result) => result.fold(
          (metrics) => metrics,
          (error) => DashboardMetrics.empty(),
        ),
      );
});

/// FutureProvider for AI-driven scheduling and logistics insights.
final schedulerInsightsProvider = FutureProvider.autoDispose<List<IntelligenceInsight>>((
  ref,
) async {
  ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 10));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.scheduling,
  );
  if (!canExecute) {
    return const [];
  }

  // Simulate AI computation for staffing optimization and route clustering
  await Future<void>.delayed(const Duration(milliseconds: 1500));

  return [
    IntelligenceInsight(
      id: 'sched_01',
      title: 'Overtime Prevention Alert',
      summary:
          '3 PSWs are approaching 40-hour threshold with 2 days remaining in pay cycle.',
      impact: InsightImpact.high,
      type: InsightType.efficiency,
      category: 'Payroll',
      recommendation:
          'Reassign night shifts for Sector 4 to prevent overtime payouts.',
    ),
    IntelligenceInsight(
      id: 'sched_02',
      title: 'Travel Optimization Opportunity',
      summary:
          'Route grouping efficiency could be improved by 18% in the GTA cluster via clustering.',
      impact: InsightImpact.medium,
      type: InsightType.optimization,
      category: 'Logistics',
      recommendation:
          'Apply Logistics Cluster Filter to the current shift roster.',
    ),
    IntelligenceInsight(
      id: 'sched_03',
      title: 'Shift Coverage Gap',
      summary:
          'Projected 12% coverage deficit for upcoming weekend in high-acuity zones.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Care Continuity',
      recommendation:
          'Trigger "Urgent Fill" notifications for on-call relief staff.',
    ),
  ];
});

final schedulerDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<SchedulerDashboardViewModel>>((
      ref,
    ) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'scheduler_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.scheduling,
      );

      try {
        if (!canExecute) {
          throw Exception('Scheduling subsystem is degraded or offline');
        }
        // Watch metrics and insights
        final metrics = await ref.watch(schedulerMetricsProvider.future);
        final insights = await ref.watch(schedulerInsightsProvider.future);

        final viewModel = SchedulerDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'Scheduler Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'Scheduler Metrics Fallback Triggered: $e',
        );
        return _handleSchedulerFallback(resilience, cacheKey, telemetry);
      }
    });

Result<SchedulerDashboardViewModel> _handleSchedulerFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = SchedulerDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Scheduler Cache corruption detected: $e',
      );
    }
  }
  return Success(SchedulerDashboardViewModel.empty(isOfflineFallback: true));
}
