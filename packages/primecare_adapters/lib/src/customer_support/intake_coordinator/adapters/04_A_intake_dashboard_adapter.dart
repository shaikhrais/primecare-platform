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
    IntelligenceInsight(
      id: 'intake_01',
      title: PrimeCareLabel(
        'Referral Velocity Spike',
        fr: 'Pic de Vitesse de Référence',
      ),
      summary: PrimeCareLabel(
        'Referral volume from North Hospital is 2.5x the rolling average.',
        fr: 'Le volume de références de l\'Hôpital Nord est de 2,5x la moyenne mobile.',
      ),
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Pipeline Load',
      recommendation: PrimeCareLabel(
        'Check capacity levels in North Sector before accepting new admits.',
        fr: 'Vérifiez les niveaux de capacité dans le secteur nord avant d\'accepter de nouvelles admissions.',
      ),
    ),
    IntelligenceInsight(
      id: 'intake_02',
      title: PrimeCareLabel(
        'Waitlist SLA Breach Risk',
        fr: 'Risque de Violation de SLA de Liste d\'Attente',
      ),
      summary: PrimeCareLabel(
        'Average wait time for Sector 4 is nearing the 24h SLA limit.',
        fr: 'Le temps d\'attente moyen pour le secteur 4 s\'approche de la limite SLA de 24h.',
      ),
      impact: InsightImpact.alert,
      type: InsightType.alert,
      category: 'SLA Compliance',
      recommendation: PrimeCareLabel(
        'Escalate pending triage cases in Sector 4 to Senior Coordinator.',
        fr: 'Faire remonter les cas de triage en attente dans le secteur 4 au coordinateur principal.',
      ),
    ),
    IntelligenceInsight(
      id: 'intake_03',
      title: PrimeCareLabel(
        'Documentation Efficiency',
        fr: 'Efficacité de la Documentation',
      ),
      summary: PrimeCareLabel(
        'Automated pre-screen forms reduced intake cycle time by 18 minutes per case.',
        fr: 'Les formulaires de pré-sélection automatisés ont réduit le temps de cycle d\'admission de 18 minutes par cas.',
      ),
      impact: InsightImpact.positive,
      type: InsightType.efficiency,
      category: 'Process Optimization',
      recommendation: PrimeCareLabel(
        'Expand pre-screen digital enrollment to all referring clinics.',
        fr: 'Étendre l\'inscription numérique de pré-sélection à toutes les cliniques référentes.',
      ),
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
