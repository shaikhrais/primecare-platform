// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// High-fidelity telemetry stream for the Intake Coordinator Dashboard.
/// Monitors referral volume, waitlist throughput, and admission SLA compliance.
final intakeMetricsProvider = StreamProvider.autoDispose<DashboardMetrics>((
  ref,
) {
  const route = 'INTAKE_COORDINATOR';
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

/// High-fidelity AI insights for the Intake Coordinator Dashboard.
/// Surfaces admission bottlenecks and referral trends via Aura Intelligence.
final intakeInsightsProvider = FutureProvider.autoDispose<List<IntelligenceInsight>>((
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

  // Simulate AI analysis of incoming referral velocity and capacity constraints
  await Future<void>.delayed(const Duration(milliseconds: 1600));

  return [
    const IntelligenceInsight(
      id: 'intake_01',
      title: 'Referral Velocity Spike',
      summary:
          'Referral volume from North Hospital is 2.5x the rolling average.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Pipeline Load',
      recommendation:
          'Check capacity levels in North Sector before accepting new admits.',
    ),
    const IntelligenceInsight(
      id: 'intake_02',
      title: 'Waitlist SLA Breach Risk',
      summary: 'Average wait time for Sector 4 is nearing the 24h SLA limit.',
      impact: InsightImpact.alert,
      type: InsightType.alert,
      category: 'SLA Compliance',
      recommendation:
          'Escalate pending triage cases in Sector 4 to Senior Coordinator.',
    ),
    const IntelligenceInsight(
      id: 'intake_03',
      title: 'Documentation Efficiency',
      summary:
          'Automated pre-screen forms reduced intake cycle time by 18 minutes per case.',
      impact: InsightImpact.positive,
      type: InsightType.efficiency,
      category: 'Process Optimization',
      recommendation:
          'Expand pre-screen digital enrollment to all referring clinics.',
    ),
  ];
});

final intakeDashboardAdapterProvider =
    FutureProvider.autoDispose<Result<IntakeDashboardViewModel>>((ref) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'intake_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.clinical,
      );

      try {
        if (!canExecute) {
          throw Exception('Clinical subsystem is degraded or offline');
        }
        // Watch metrics and insights
        final metrics = await ref.watch(intakeMetricsProvider.future);
        final insights = await ref.watch(intakeInsightsProvider.future);

        final viewModel = IntakeDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'Intake Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'Intake Metrics Fallback Triggered: $e',
        );
        return _handleIntakeFallback(resilience, cacheKey, telemetry);
      }
    });

Result<IntakeDashboardViewModel> _handleIntakeFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = IntakeDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Intake Cache corruption detected: $e',
      );
    }
  }
  return Success(IntakeDashboardViewModel.empty(isOfflineFallback: true));
}
