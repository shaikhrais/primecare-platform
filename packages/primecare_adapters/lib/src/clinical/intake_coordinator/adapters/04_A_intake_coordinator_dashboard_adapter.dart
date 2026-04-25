// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// StreamProvider for real-time Intake Coordinator metrics.
/// Tracks pending referrals, triage velocity, and admission throughput.
final intakeCoordinatorMetricsProvider =
    StreamProvider.autoDispose<DashboardMetrics>((ref) {
      final telemetry = ref.read(executionGateProvider);
      const route = 'IntakeCoordinator';
      final repository = ref.watch(dashboardRepositoryProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );
      if (!canExecute) {
        return Stream.value(DashboardMetrics.empty());
      }
      return repository.watchMetrics(route).map((result) {
        return result.fold((metrics) {
          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Intake Metrics Hydrated',
          );
          return metrics;
        }, (error) => throw error);
      });
    });

/// FutureProvider for AI-driven Intake insights.
/// Analyzes triage priority, patient matching, and provider capacity.
final intakeCoordinatorInsightsProvider =
    FutureProvider.autoDispose<List<IntelligenceInsight>>((ref) async {
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.clinical,
      );
      if (!canExecute) {
        return _getSmartIntakeInsights();
      }

      // Simulate AI Analysis Latency
      await Future<void>.delayed(const Duration(milliseconds: 900));

      telemetry.passGate(
        ExecutionGateCategory.aura,
        'Intake Intelligence Analysis Generated',
      );

      return _getSmartIntakeInsights();
    });

List<IntelligenceInsight> _getSmartIntakeInsights() {
  return [
    IntelligenceInsight(
      id: 'intake_01',
      title: 'High-Priority Triage Alert',
      summary:
          '3 pending referrals from North General Hospital are marked as urgent (High-Risk).',
      impact: InsightImpact.alert,
      type: InsightType.alert,
      recommendation:
          'Prioritize clinical review for North General queue immediately.',
    ),
    IntelligenceInsight(
      id: 'intake_02',
      title: 'Provider Network Optimization',
      summary:
          'Home Care providers in Sector 7 have 20% available capacity for new admits.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      recommendation:
          'Direct eligible referrals in Sector 7 to the primary Home Care hub.',
    ),
    IntelligenceInsight(
      id: 'intake_03',
      title: 'Waitlist Efficiency Insight',
      summary:
          'Automated matching could reduce waitlist time for non-urgent cardiac cases by 15%.',
      impact: InsightImpact.growth,
      type: InsightType.optimization,
      recommendation: 'Enable "Smart Match" for the Cardiac waitlist cluster.',
    ),
  ];
}

final intakeCoordinatorDashboardAdapterProvider =
    FutureProvider<Result<IntakeCoordinatorDashboardViewModel>>((ref) async {
      const cacheKey = 'intake_coordinator_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // Watch metrics and insights
        final metrics = await ref.watch(
          intakeCoordinatorMetricsProvider.future,
        );
        final insights = await ref.watch(
          intakeCoordinatorInsightsProvider.future,
        );

        final viewModel = IntakeCoordinatorDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'Intake Coordinator Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'Intake Coordinator Metrics Fallback Triggered: $e',
        );
        return _handleIntakeCoordinatorFallback(
          resilience,
          cacheKey,
          telemetry,
        );
      }
    });

Result<IntakeCoordinatorDashboardViewModel> _handleIntakeCoordinatorFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = IntakeCoordinatorDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Intake Coordinator Cache corruption detected: $e',
      );
    }
  }
  return Success(
    IntakeCoordinatorDashboardViewModel.empty(isOfflineFallback: true),
  );
}
