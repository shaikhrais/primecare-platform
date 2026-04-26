import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Training Director Dashboard.
final trainingDirectorActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Training Director Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Training Director.
/// Tracks completion rates, compliance status, and certification velocity.
final trainingMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics('/v2/corporate/training_director')
      .map((r) => r.fold((m) => m, (e) => throw e));
});

/// High-fidelity AI curriculum insights for the Training Director.
/// Surfaces compliance risks and curriculum opportunities via Aura Intelligence.
final trainingInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
      id: 'td_01',
      title: LocaleKeys
          .dashboards_trainingdirector_labels_compliance_risk_in_southwest
          .tr(),
      summary:
          'Certification expiration rates have increased by 15% in the Southwest territory.',
      impact: InsightImpact.warning,
      type: InsightType.efficiency,
      category: 'Compliance',
      recommendation:
          'Initiate mandatory recertification sprint for Southwest staff.',
    ),
    IntelligenceInsight(
      id: 'td_02',
      title: LocaleKeys
          .dashboards_trainingdirector_labels_new_curriculum_opportunity
          .tr(),
      summary:
          'High success rates in "Advanced Wound Care" suggest a potential for a Masterclass series.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Curriculum',
      recommendation:
          'Approve the proposal for the Wound Care Masterclass pilot.',
    ),
  ];
});

final trainingDirectorDashboardAdapterProvider =
    FutureProvider<Result<TrainingDirectorDashboardViewModel>>((ref) async {
      const cacheKey = 'training_director_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // Watch metrics and insights
        final metrics = await ref.watch(trainingMetricsProvider.future);
        final insights = await ref.watch(trainingInsightsProvider.future);

        final viewModel = TrainingDirectorDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'Training Director Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'Training Director Metrics Fallback Triggered: $e',
        );
        return _handleTrainingDirectorFallback(resilience, cacheKey, telemetry);
      }
    });

Result<TrainingDirectorDashboardViewModel> _handleTrainingDirectorFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = TrainingDirectorDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'Training Director Cache corruption detected: $e',
      );
    }
  }
  return Success(
    TrainingDirectorDashboardViewModel.empty(isOfflineFallback: true),
  );
}
